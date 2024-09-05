import time
import numbers
from . combine import Combiner
from . explain4 import Explainer, prog_hash
from . util import timeout, format_rule, rule_is_recursive, order_prog, prog_is_recursive, prog_has_invention, \
    has_rec_no_base_case, order_rule, prog_size, rule_is_invented, prog_is_recursive2
from . tester import Tester
from . generate import Generator, Grounder, parse_model, atom_to_symbol, arg_to_symbol
from . bkcons import deduce_bk_cons
from . rewrite import Rewriter
from . core import is_ho_prog

def parse_handles(generator, new_handles):
    for rule in new_handles:
        head, body = rule
        # TODO: add caching
        for h, b in generator.get_ground_rules(rule):
            _, p, args = h
            out_h = (p, args)
            out_b = frozenset((b_pred, b_args) for _, b_pred, b_args in b)
            yield (out_h, out_b)

def explain_incomplete(settings, generator, explainer, rewriter, prog, directions, new_cons, all_handles, bad_handles, new_ground_cons):
    pruned_subprog = False

    for subprog, unsat_body in explainer.explain_totally_incomplete(rewriter, prog, directions):
        pruned_subprog = True

        if unsat_body:
            _, body = subprog[0]
            con = generator.unsat_constraint(body)
            for h, b in generator.get_ground_deep_rules(con):
                new_ground_cons.add(b)
            continue

        new_rule_handles, con = generator.build_specialisation_constraint(subprog)
        new_cons.add(con)
        all_handles.update(parse_handles(generator, new_rule_handles))

        if not settings.recursion_enabled or settings.pi_enabled:
            continue

        if len(subprog) == 1:
            bad_handle, new_rule_handles, con = generator.redundancy_constraint1(subprog)
            bad_handles.add(bad_handle)
            new_cons.add(con)
            all_handles.update(parse_handles(generator, new_rule_handles))

        handles, cons = generator.redundancy_constraint2(subprog)
        new_cons.update(cons)
        all_handles.update(parse_handles(generator, handles))

    return pruned_subprog

def explain_inconsistent(settings, generator, tester, prog, rewriter, directions, rule_ordering, new_cons, all_handles):
    if len(prog) == 1 or not settings.recursion_enabled:
        return False

    base = []
    rec = []
    for rule in prog:
        if rule_is_recursive(rule):
            rec.append(rule)
        else:
            base.append(rule)

    pruned_subprog = False
    for rule in base:
        subprog = frozenset([rule])
        test_subprog, _ = rewriter.rewrite(subprog, directions)
        if tester.is_inconsistent(test_subprog):
            new_rule_handles, con = generator.build_generalisation_constraint(subprog)
            new_cons.add(con)
            all_handles.update(parse_handles(generator, new_rule_handles))
            pruned_subprog = True

    if pruned_subprog:
        return True

    if len(rec) == 1:
        return False

    for r1 in base:
        for r2 in rec:
            subprog = frozenset([r1,r2])
            test_subprog, _ = rewriter.rewrite(subprog, directions)
            if tester.is_inconsistent(test_subprog):
                new_rule_handles, con = generator.build_generalisation_constraint(subprog)
                new_cons.add(con)
                all_handles.update(parse_handles(generator, new_rule_handles))
                pruned_subprog = True
    return pruned_subprog

def constrain(settings, new_cons, generator, all_ground_cons, cached_clingo_atoms, model, new_ground_cons):
    all_ground_cons.update(new_ground_cons)
    ground_bodies = set()
    ground_bodies.update(new_ground_cons)

    with settings.stats.duration('ground'):
        for con in new_cons:
            ground_rules = generator.get_ground_rules((None, con))
            for ground_rule in ground_rules:
                _ground_head, ground_body = ground_rule
                ground_bodies.add(ground_body)
                all_ground_cons.add(frozenset(ground_body))

    with settings.stats.duration('constrain'):
        for ground_body in ground_bodies:
            nogood = []
            for sign, pred, args in ground_body:
                k = hash((sign, pred, args))
                if k in cached_clingo_atoms:
                    nogood.append(cached_clingo_atoms[k])
                else:
                    x = (atom_to_symbol(pred, args), sign)
                    cached_clingo_atoms[k] = x
                    nogood.append(x)
            model.context.add_nogood(nogood)

def popper(settings):
    if settings.bkcons:
        deduce_bk_cons(settings)

    tester = Tester(settings)
    explainer = Explainer(settings, tester)
    grounder = Grounder(settings)
    combiner = Combiner(settings, tester)

    TMP_INCONSISTENT = set()
    TMP_COUNT = 0

    settings.single_solve = not (settings.recursion_enabled or settings.pi_enabled or settings.ho_enabled)

    num_pos = len(settings.pos)

    # track the success sets of tested hypotheses
    success_sets = {}
    rec_success_sets = {}
    last_size = None

    # caching
    cached_clingo_atoms = {}

    # for micro-optimisations
    seen_covers_only_one_gen = set()
    seen_covers_only_one_spec = set()
    seen_incomplete_gen = set()
    seen_incomplete_spec = set()

    # constraints generated
    all_ground_cons = set()
    # messy stuff
    new_ground_cons = set()
    # new rules added to the solver, such as: seen(id):- head_literal(...), body_literal(...)
    all_handles = set()
    # handles for rules that are minimal and unsatisfiable
    bad_handles = set()

    # generator that builds programs
    generator = Generator(settings, grounder)

    max_size = (1 + settings.max_body) * settings.max_rules

    rewriter = Rewriter(generator.higher_order_preds)
    for size in range(1, max_size+1):
        if size > settings.max_literals:
            break

        # if there is no PI or recursion, we only add nogoods
        # otherwise we build constraints and add them as nogoods and then again as constraints to the solver
        if not settings.single_solve:
            settings.logger.info(f'SIZE: {size} MAX_SIZE: {settings.max_literals}')
            generator.update_number_of_literals(size)

            with settings.stats.duration('init'):
                generator.update_solver(size, all_handles, bad_handles, all_ground_cons)

        all_ground_cons = set()
        all_handles = set()
        bad_handles = set()

        with generator.solver.solve(yield_ = True) as handle:
            # use iter so that we can measure running time
            handle = iter(handle)

            while True:
                new_cons = set()
                new_rule_handles = set()
                new_ground_cons = set()
                pruned_sub_incomplete = False
                pruned_sub_inconsistent = False

                # GENERATE A PROGRAM
                with settings.stats.duration('generate'):
                    # get the next model from the solver
                    model = next(handle, None)
                    if model is None:
                        break
                    atoms = model.symbols(shown = True)
                    # print(atoms)
                    prog, rule_ordering, directions = parse_model(atoms)

                is_recursive = settings.recursion_enabled and prog_is_recursive(prog)
                has_invention = prog_has_invention(prog)

                settings.stats.total_programs += 1

                # TEST A PROGRAM
                test_program, directions = rewriter.rewrite(prog, directions)

                if settings.debug:
                    settings.logger.debug(f'Program {settings.stats.total_programs}:')
                    for rule in order_prog(test_program):
                        settings.logger.debug(format_rule(order_rule(rule)))

                if has_rec_no_base_case(test_program):
                    handles, con = generator.build_generalisation_constraint(prog, rule_ordering)
                    new_rule_handles.update(handles)
                    new_cons.add(con)
                    handles, con = generator.build_specialisation_constraint(prog, rule_ordering)
                    new_rule_handles.update(handles)
                    new_cons.add(con)
                    constrain(settings, new_cons, generator, all_ground_cons, cached_clingo_atoms, model,
                              new_ground_cons)
                    continue

                # TEST A PROGRAM
                with settings.stats.duration('test'):
                    pos_covered, inconsistent = tester.test_prog(test_program)
                    num_pos_covered = len(pos_covered)

                # EXPLAIN A FAILURE
                if settings.explain and not has_invention:
                    explainer.add_seen(test_program)
                    if len(pos_covered) == 0:
                        with settings.stats.duration('explain_incomplete'):
                            pruned_sub_incomplete = explain_incomplete(settings, generator, explainer, rewriter, prog, directions, new_cons, all_handles, bad_handles, new_ground_cons)

                if inconsistent and is_recursive:
                    combiner.add_inconsistent(test_program)

                # messy way to track program size
                if settings.single_solve:
                    k = prog_size(test_program)
                    if last_size == None or k != last_size:
                        last_size = k
                        settings.logger.info(f'Searching programs of size: {k}')
                    if k > settings.max_literals:
                         break

                add_spec = False
                add_gen = False
                add_redund1 = False
                add_redund2 = False

                if inconsistent:
                    # if inconsistent, prune generalisations
                    add_gen = True
                    if settings.explain and settings.recursion_enabled and not has_invention:
                        with settings.stats.duration('explain_inconsistent'):
                            pruned_sub_inconsistent = explain_inconsistent(settings, generator, tester, prog, rewriter, directions, rule_ordering, new_cons, all_handles)
                else:
                    # if consistent, prune specialisations
                    add_spec = True

                # if consistent and partially complete test whether functional
                if not inconsistent and settings.functional_test and num_pos_covered > 0 and tester.is_non_functional(test_program):
                    # if not functional, rule out generalisations and set as inconsistent
                    add_gen = True
                    # v.important: do not prune specialisations!
                    add_spec = False
                    inconsistent = True

                # if it does not cover any example, prune specialisations
                if num_pos_covered == 0:
                    add_spec = True
                    # if recursion and no PI, apply redundancy constraints
                    if settings.recursion_enabled and not (prog_is_recursive2(prog) and
                                                           any([rule_is_invented(rule) for rule in prog])) and not is_ho_prog(prog):
                        add_redund2 = True
                        if len(test_program) == 1 and not settings.pi_enabled:
                            add_redund1 = True

                # remove generalisations of programs with redundant literals
                if settings.recursion_enabled:
                    if not add_gen or len(test_program) > 1:
                        for rule in test_program:
                            if tester.has_redundant_literal([rule]):
                                add_gen = True
                                if len(test_program) > 1:
                                    new_handles, con = generator.build_generalisation_constraint([rule])
                                    new_cons.add(con)
                                    all_handles.update(parse_handles(generator, new_handles))

                # remove a subset of theta-subsumed rules when learning recursive programs with more than two rules
                if settings.recursion_enabled and settings.max_rules > 2 and is_recursive:
                    for x in generator.tmp_con(test_program):
                        new_cons.add(x)

                # remove generalisations of programs with redundant rules
                if settings.recursion_enabled and len(test_program) > 2 and tester.has_redundant_rule(test_program):
                    add_gen = True
                    r1, r2 = tester.find_redundant_rules(prog)
                    new_handles, con = generator.build_generalisation_constraint([r1,r2])
                    new_cons.add(con)
                    all_handles.update(parse_handles(generator, new_handles))

                # check whether subsumed by a seen program
                subsumed = False

                # WHY DO WE HAVE A RECURSIVE CHECK???
                if num_pos_covered > 0 and not not prog_is_recursive(test_program):
                # if num_pos_covered > 0:
                    subsumed = pos_covered in success_sets or any(pos_covered.issubset(xs) for xs in success_sets)
                    # if so, prune specialisations
                    if subsumed:
                        add_spec = True

                # micro-optimisiations
                if not settings.recursion_enabled:

                    # if we already have a solution, a new rule must cover at least two examples
                    if not add_spec and combiner.solution_found and num_pos_covered == 1:
                        add_spec = True

                    # keep track of programs that only cover one example
                    # once we find a solution, we apply specialisation/generalisation constraints
                    if num_pos_covered == 1:
                        if not add_gen:
                            seen_covers_only_one_gen.add(prog)
                        if not add_spec:
                            seen_covers_only_one_spec.add(prog)

                    # keep track of programs that do not cover all the examples
                    if num_pos_covered != num_pos:
                        if not add_gen:
                            seen_incomplete_gen.add(prog)
                        if not add_spec:
                            seen_incomplete_spec.add(prog)

                    # if we find a solution, prune programs that only cover one example
                    # reset the sets to avoid adding duplicate constraints
                    if combiner.solution_found:
                        for x in seen_covers_only_one_gen:
                            new_handles, con = generator.build_generalisation_constraint(x)
                            new_cons.add(con)
                            all_handles.update(parse_handles(generator, new_handles))

                        seen_covers_only_one_gen = set()
                        for x in seen_covers_only_one_spec:
                            new_handles, con = generator.build_specialisation_constraint(x)
                            new_cons.add(con)
                            all_handles.update(parse_handles(generator, new_handles))
                        seen_covers_only_one_spec = set()

                        if len(combiner.best_prog) <= 2:
                            for x in seen_incomplete_gen:
                                new_handles, con = generator.build_generalisation_constraint(x)
                                new_cons.add(con)
                                all_handles.update(parse_handles(generator, new_handles))
                            for x in seen_incomplete_spec:
                                new_handles, con = generator.build_specialisation_constraint(x)
                                new_cons.add(con)
                                all_handles.update(parse_handles(generator, new_handles))
                            seen_incomplete_gen = set()
                            seen_incomplete_spec = set()

                seen_better_rec = False
                if is_recursive and not inconsistent and not subsumed and not add_gen and num_pos_covered > 0:
                    seen_better_rec = pos_covered in rec_success_sets or any(pos_covered.issubset(xs) for xs in rec_success_sets)

                # if consistent, covers at least one example, is not subsumed, and has no redundancy, try to find a solution
                # if not inconsistent and not subsumed and not add_gen and num_pos_covered > 0:
                if not inconsistent and not subsumed and not add_gen and num_pos_covered > 0 and not seen_better_rec:

                    # update success sets
                    success_sets[pos_covered] = test_program
                    if is_recursive:
                        rec_success_sets[pos_covered] = test_program

                    # COMBINE
                    with settings.stats.duration('combine'):
                        new_solution_found = combiner.update_best_prog(test_program, pos_covered)

                    # if we find a new solution, update the maximum program size
                    # if only adding nogoods, eliminate larger programs
                    if new_solution_found:
                        settings.max_literals = combiner.max_size-1
                        (tp, fn, tn, fp, size) = combiner.settings.best_prog_score
                        settings.stats.register_solution(combiner.settings.solution, (tp, fn, tn, fp))
                        settings.stats.log_final_result()
                        # if size >= settings.max_literals:
                        #     return

                        if settings.single_solve:
                            for i in range(combiner.max_size, settings.max_literals+1):
                                size_con = [(atom_to_symbol("size", (i,)), True)]
                                model.context.add_nogood(size_con)

                # if non-separable program covers all examples, stop
                if not inconsistent and num_pos_covered == num_pos:
                    for rule in order_prog(test_program):
                        settings.logger.debug(format_rule(order_rule(rule)))
                    settings.stats.register_solution(order_prog(test_program), (num_pos_covered, 0, len(settings.neg), 0))
                    settings.stats.log_final_result()
                    settings.solution = test_program
                    settings.best_prog_score = (num_pos_covered, 0, len(settings.neg), 0, prog_size(test_program))
                    if not settings.functional_test or (settings.functional_test and not tester.is_non_functional(test_program)):
                        return

                settings.logger.debug(f"constraints spec {add_spec} gen {add_gen}")
                # BUILD CONSTRAINTS
                if add_spec and not pruned_sub_incomplete:
                    handles, con = generator.build_specialisation_constraint(prog, rule_ordering)
                    new_rule_handles.update(handles)
                    new_cons.add(con)

                if add_gen and not pruned_sub_inconsistent:
                    if settings.recursion_enabled or settings.pi_enabled or not pruned_sub_incomplete:
                        handles, con = generator.build_generalisation_constraint(prog, rule_ordering)
                        new_rule_handles.update(handles)
                        new_cons.add(con)

                if add_redund1 and not pruned_sub_incomplete:
                    bad_handle, handles, con = generator.redundancy_constraint1(prog)
                    bad_handles.add(bad_handle)
                    new_rule_handles.update(handles)
                    new_cons.add(con)

                if add_redund2 and not pruned_sub_incomplete:
                    handles, cons = generator.redundancy_constraint2(prog, rule_ordering)
                    new_rule_handles.update(handles)
                    new_cons.update(cons)

                # if pi or rec, save the constraints and handles for the next program size
                if not settings.single_solve:
                    all_handles.update(parse_handles(generator, new_rule_handles))

                # CONSTRAIN
                constrain(settings, new_cons, generator, all_ground_cons, cached_clingo_atoms, model, new_ground_cons)

        # if not pi_or_rec:
        if settings.single_solve:
            break

    settings.stats.register_completion()
    settings.stats.log_final_result()

def learn_solution(settings):
    timeout(settings, popper, (settings,), timeout_duration=int(settings.timeout),)
    if settings.solution:
        for rule in order_prog(settings.solution):
            settings.logger.debug(format_rule(order_rule(rule)))
    return settings.solution, settings.best_prog_score, settings.stats

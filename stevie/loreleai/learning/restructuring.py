import datetime
import logging
import sys
from functools import reduce
from itertools import combinations
from typing import Set, Dict, List, Tuple, Iterator, Union, Sequence

from ortools.sat.python import cp_model

from stevie.loreleai.language.commons import c_pred, c_literal, c_hvar, Literal, Clause, are_variables_connected, \
    _are_two_set_of_literals_identical, _create_term_signatures, Disjunction, Recursion, SecondOrderVariable, Not, \
    alphabeticiseClausalConstruct
from stevie.loreleai.language.lp import Predicate, Term, ClausalTheory, Variable

NUM_PREDICATES = 1
NUM_LITERALS = 2


class Restructor:
    """
    Implements the theory restructuring functionality

    Args:
        max_literals (int): maximal number of literals to use in the restructuring clauses
        min_literals (int, optional): minimal number of literals to use in the restructuring clauses
        head_variable_selection (int, optional): how to select variables for the head of the latent predicate
                                                 1 - take all
                                                 2 - take max_arity vars
        max_arity (int, optional): the number of variables to take in the head of the latent predicates when
                                    head_variable_selection = 2
    """

    def __init__(self, max_literals: int, min_literals: int = 2, head_variable_selection: int = 2, max_arity: int = 2,
                 prevent_redundancies=False, minimise_redundancy=False, exact_redundancy=False, exclude_redundant_cands=False,
                 exclude_alternatives=False, reject_singleton=True, allow_no_refactoring=False,
                 objective_type=NUM_PREDICATES,
                 logl=logging.INFO, logfile: str = None, logger=None):
        self.max_literals = max_literals
        self.min_literals = min_literals
        self._objective_type = objective_type
        self.aux_candidate_counter = 0
        self.head_variable_selection_strategy = head_variable_selection
        self.max_arity = max_arity
        self.enumerated_bodies = {}
        self.enumerated_body_signatures = {}
        self.candidate_usage_count = {}
        self.minimise_redundancy = minimise_redundancy
        self.prevent_redundancies = prevent_redundancies
        self.minimise_redundancy_absolute_count = exact_redundancy
        self.reject_singletons = reject_singleton
        self.allow_no_refactoring = allow_no_refactoring
        self._candidate_exclusion = []
        self.exclude_alternatives = exclude_alternatives
        self.exclude_redundant_candidates = exclude_redundant_cands
        self.redundant_candidates = []
        self.count_candidates = 0
        self.equals_zero = None
        self.log_level = logl

        # logging setup
        self._logger = logger if logger else logging.getLogger(logfile if logfile else '')

        if logfile is not None:
            log_file = logging.FileHandler(logfile)
            log_file.setLevel(logl)
            log_file.setFormatter(logging.Formatter('[%(asctime)s] [%(levelname)s] %(message)s'))
            self._logger.addHandler(log_file)
        else:
            console_handler = logging.StreamHandler(sys.stdout)
            console_handler.setLevel(logl)
            console_handler.setFormatter(logging.Formatter('[%(asctime)s] [%(levelname)s] %(message)s'))
            self._logger.addHandler(console_handler)

        self._logger.setLevel(logl)

    def _get_candidate_index(self):
        """
        Generates a unique index for a new latent head

        Returns:
            integer
        """
        self.aux_candidate_counter += 1
        return self.aux_candidate_counter

    def __create_latent_clause(self, literals: List[Literal], variable_strategy: int = 1, max_arity: int = 2) -> List[Clause]:
        if not are_variables_connected(literals):
            # if the variables are not connected in a graph, that makes it an invalid candidate
            return []

        head_name = f'latent{self._get_candidate_index()}'
        available_vars = {}
        for lit in literals:
            for v in lit.get_variables():
                if v not in available_vars:
                    available_vars[v] = len(available_vars)
        available_vars = sorted(available_vars, key=lambda x: available_vars[x])

        if variable_strategy == 1 or len(available_vars) == max_arity:
            # take all variables or number of variables is equal to ifthenelse_max arity
            head_pred = c_pred(head_name, len(available_vars), [x.get_type() for x in available_vars])
            # Predicate(head_name, len(available_vars), [x.get_type() for x in available_vars])
            atom = c_literal(head_pred, available_vars)  # Atom(head_pred, available_vars)
            cl = Clause(atom, literals)

            if self.reject_singletons and cl.has_singleton_var():
                return []
            else:
                self.count_candidates += 1
                return [cl]
        elif variable_strategy == 2:
            # need to select a subset of variables
            clauses = []

            for ind, var_cmb in enumerate(combinations(available_vars, max_arity)):
                # head_pred = Predicate(f'{head_name}_{ind + 1}', len(var_cmb), [x.get_type() for x in var_cmb])
                head_pred = c_pred(f'{head_name}_{ind + 1}', len(var_cmb), [x.get_type() for x in var_cmb])
                atom = c_literal(head_pred, list(var_cmb))  # Atom(head_pred, list(var_cmb))
                cl = Clause(atom, literals)

                if self.reject_singletons and cl.has_singleton_var():
                    pass
                else:
                    self.count_candidates += 1
                    clauses.append(cl)

            # remember the alternatives, and add constraint that only one of these can be taken
            # assumes that all candidates have unique heads
            if self.exclude_alternatives and len(clauses) > 1:
                self._candidate_exclusion.append([x.get_head().get_predicate().get_name() for x in clauses])

            return clauses
        else:
            raise Exception(f'Unknown head variable selection strategy {variable_strategy}')

    def __process_candidates(self, accumulator: Dict[Predicate, Set[Clause]], clause: Clause) -> Dict[Predicate, Set[Clause]]:
        for length in range(self.min_literals, self.max_literals + 1):
            for cmb in combinations(clause.get_atoms(), length):
                cmb = list(cmb)
                # predicate_sig =  set([x.get_predicate() for x in cmb])
                predicate_sig = tuple(sorted([x.get_predicate() for x in cmb], key=lambda x: x.get_name()))

                potential_matches = [x for x in self.enumerated_bodies.get(predicate_sig, []) if len(x) == len(cmb)]

                if not any([_are_two_set_of_literals_identical(cmb, self.enumerated_body_signatures[x]) for x in potential_matches]):

                    if predicate_sig not in self.enumerated_bodies:
                        self.enumerated_bodies[predicate_sig] = set()

                    self.enumerated_bodies[predicate_sig].add(tuple(cmb))
                    self.enumerated_body_signatures[tuple(cmb)] = _create_term_signatures(cmb)

                    clauses = self.__create_latent_clause(list(cmb), self.head_variable_selection_strategy, self.max_arity)
                    for cl in clauses:
                        for p in predicate_sig:
                            if p not in accumulator:
                                accumulator[p] = set()
                            accumulator[p].add(cl)

        return accumulator

    def _get_candidates(self, clauses: Union[ClausalTheory, Sequence[Clause]]) -> Dict[Predicate, Set[Clause]]:
        """
        Extracts candidates for restructuring from the clauses in the theory

        Args:
            clauses: theory, a set of clauses to restructure

        Returns:
            a set of candidates represented as a dictionary:
                -- key: predicate
                -- value: all clauses having that predicate in the body
        """
        self._logger.info("Enumerating candidates...")

        return reduce(self.__process_candidates,
                      clauses.get_formulas() if isinstance(clauses, ClausalTheory) else clauses,
                      {})

    def __encode(self, atoms_to_cover: Sequence[Literal],
                 atoms_covered: Set[Literal],
                 atom_covering: Dict[Literal, Dict[Clause, Set[Tuple[List[Literal], Dict[Term, Term]]]]],
                 target_clause_head_vars: Set[Variable],
                 prefix=" ",
                 allow_partial=False) -> Tuple[Set[Set[Literal]], Set[Clause]]:
        """
        Encoding of a set of atoms
        :param atoms_to_cover:
        :param atoms_covered:
        :param atom_covering:
        :param prefix:
        :return:
        """

        if len(atoms_to_cover) == 0:
            return set(), set()

        focus_atom = atoms_to_cover[0]
        # self._logger.debug(f'{prefix}| focusing on {focus_atom}')

        matching_clauses = atom_covering[focus_atom].keys()
        used_clauses = set()
        # print(f'{prefix}|  found matching clauses {matching_clauses}')
        encodings = set()

        for cl in matching_clauses:
            for match in atom_covering[focus_atom][cl]:
                # self._logger..debug(f'{prefix}|    processing clause {cl} with match {match}')
                atms, sbs = match  # subs: key - variables in cl, value -- variables to use as the substitutions (from )
                new_atoms_to_cover = [x for x in atoms_to_cover if x not in atms and x != focus_atom]
                new_atoms_covered = atoms_covered.union(atms)

                # make sure that none of the variables that would be kicked out are needed in the rest of the body
                retained_variables = set([sbs[x] for x in cl.get_head().get_variables()])
                kicked_out_variables = reduce((lambda x, y: x + y), [x.get_variables() for x in atms], [])
                kicked_out_variables = [x for x in kicked_out_variables if x not in retained_variables]

                if len(new_atoms_to_cover):
                    variables_in_the_rest_of_the_body = reduce((lambda x, y: x.union(y)), [x.get_variables() for x in new_atoms_to_cover], set()).union(target_clause_head_vars)
                else:
                    variables_in_the_rest_of_the_body = target_clause_head_vars

                if any([x in variables_in_the_rest_of_the_body for x in kicked_out_variables]):
                    if allow_partial:
                        encodings.add({focus_atom})
                    else:
                        continue
                else:
                    used_clauses.add(cl)
                    # self._logger.debug(f'{prefix}|      atoms covered: {new_atoms_covered}; atoms to cover: {new_atoms_to_cover}')
                    encoding_rest, inner_used = self.__encode(new_atoms_to_cover, new_atoms_covered, atom_covering, target_clause_head_vars.union(retained_variables), prefix=prefix * 2)
                    used_clauses = used_clauses.union(inner_used)
                    # self._logger.debug(f'{prefix}|      encodings of the rest: {encoding_rest}')

                    if len(encoding_rest) == 0 and len(new_atoms_to_cover) == 0:
                        encodings.add(frozenset({cl.get_head().substitute(sbs)}))
                    else:
                        for enc_rest in encoding_rest:
                            encodings.add(enc_rest.union([cl.get_head().substitute(sbs)]))

        return encodings, used_clauses

    def _encode_clause(self, clause: Clause,
                       candidates: Dict[Predicate, Set[Clause]],
                       originating_clause: Clause,
                       allow_partial=False) -> List[Clause]:
        """
        Finds all possible encodings of the given clause by means of candidates

        Args:
            clause (Clause): a clause to encode
            candidates (Dict[Predicate, Set[Clause]): candidates to use to encode the provided clause
        """
        self._logger.warning(f'\tencoding clause {clause}')

        clause_predicates = clause.get_predicates()
        filtered_candidates = dict([(k, v) for (k, v) in candidates.items() if k in clause_predicates])
        partial_rew_preds = reduce((lambda x, y: x.union(y)), filtered_candidates.values())
        partial_rew_preds = set([x.get_head().get_predicate() for x in partial_rew_preds if len(x) == 1])

        # create index structure so that it is easy to get to the candidates that cover different atoms
        atom_to_covering_clause_index = {}
        for p in filtered_candidates:
            for cand in filtered_candidates[p]:
                for answer in cand.is_part_of(clause):
                    atms, sbs = answer
                    if len(sbs) == 0:
                        continue
                    for atm in atms:
                        if atm not in atom_to_covering_clause_index:
                            atom_to_covering_clause_index[atm] = {}
                        if cand not in atom_to_covering_clause_index[atm]:
                            atom_to_covering_clause_index[atm][cand] = []
                        if answer not in atom_to_covering_clause_index[atm][cand]:
                            atom_to_covering_clause_index[atm][cand].append(answer)

        encoding, used_clauses = self.__encode(clause.get_atoms(), set(), atom_to_covering_clause_index, set(clause.get_head().get_variables()), allow_partial=allow_partial)
        # if refactoring does not reduce the length on th clause, reject it
        #       reject also if the refactored clause mostly consists of unary mappings (partial rewrites)
        encoding = [Clause(clause.get_head(), list(x)) for x in encoding if len(x) < len(clause)]

        filtered_1 = [x for x in encoding if len(partial_rew_preds.intersection(x.get_predicates())) < int(len(clause)/2)]
        # if len(filtered_1) == 0:
        #     filtered_1 = [x for x in encoding if len(partial_rew_preds.intersection(x.get_predicates())) <= int(len(clause)/2)]
        encoding = [x for x in filtered_1]

        for cl in encoding:
            cl.add_property("parent", originating_clause if originating_clause else clause)

        # update candidate counts
        for cl in used_clauses:
            if cl not in self.candidate_usage_count:
                self.candidate_usage_count[cl] = 0
            self.candidate_usage_count[cl] += 1

        return list(encoding)

    def _prune_candidate_set(self, candidates: Dict[Predicate, Set[Clause]]) -> Tuple[Dict[Predicate, Set[Clause]], Set[Clause]]:
        """
        Prunes the set of candidates; removes all candidates for which
            length(candidate) * usage(candidate) < length(candidate) + usage(candidate)

        Returns:
            in set: candidates to keep
            out set: pruned candidates
        """

        return dict([(k, set([x for x in v if len(x) * self.candidate_usage_count.get(x, 0) > len(x) + self.candidate_usage_count.get(x, 0)])) for k, v in candidates.items()]), \
                reduce((lambda x, y: x.union(y)), [set([x for x in v if len(x) * self.candidate_usage_count.get(x, 0) <= len(x) + self.candidate_usage_count.get(x, 0)]) for k, v in candidates.items()], set())

    def _encode_theory(self, theory: Union[ClausalTheory, Sequence[Clause]],
                       candidates: Dict[Predicate, Set[Clause]],
                       originating_clause: Clause = None) -> Dict[Clause, Sequence[Clause]]:
        """
        Encodes the entire theory with the provided candidates

        Args:
            theory (Theory): a set of clauses to encode
            candidates (Dict[Predicate, Set[Clause]]): clauses to use for encoding the theory

        """
        self._logger.info(f'Encoding theory...')
        return dict([(x, self._encode_clause(x, candidates, originating_clause if originating_clause else x)) for x in (theory.get_formulas() if isinstance(theory, ClausalTheory) else theory)])

    def _find_redundancies(self, encoded_clauses: Dict[Clause, Sequence[Clause]]) -> Tuple[Dict[Sequence[str], Sequence[Clause]], Sequence[Sequence[str]]]:
        """
        Identifies all redundancies in possible encodings

        Args:
            encoded_clauses (Dict[Clause, Set[Set[Literal]]]): encoded clauses
        """
        self._logger.info(f'Finding redundancies...')

        redundancy_counts = {}
        cooccurrence_counts = {}

        for cl in encoded_clauses:
            inner_counts = {}

            for enc_cl in encoded_clauses[cl]:
                enc = enc_cl.get_atoms()
                for l in range(2, len(enc) + 1):
                    for env_cmb in combinations(enc, l):
                        if not are_variables_connected(env_cmb):
                            continue

                        env_cmb = sorted(env_cmb, key=lambda x: x.get_predicate().get_name())

                        # order variables
                        var_indices = {}
                        for atm in env_cmb:
                            for v in atm.get_variables():
                                if v not in var_indices:
                                    var_indices[v] = len(var_indices)

                        # count coocurrences of latent predicates
                        pred_tuple = tuple([x.get_predicate().get_name() for x in env_cmb])
                        if pred_tuple not in cooccurrence_counts:
                            cooccurrence_counts[pred_tuple] = 0
                        cooccurrence_counts[pred_tuple] += 1

                        # create informative key (not depending on variable names)
                        env_cmb = tuple([f'{x.get_predicate().get_name()}({",".join([str(var_indices[y]) for y in x.get_variables()])})' for x in env_cmb])

                        if env_cmb not in inner_counts:
                            inner_counts[env_cmb] = []
                        inner_counts[env_cmb].append(enc_cl)

            for t in inner_counts:
                if t not in redundancy_counts:
                    redundancy_counts[t] = []
                redundancy_counts[t] += inner_counts[t]

        return dict([(k, v) for k, v in redundancy_counts.items() if len(v) > 1]), [k for k, v in cooccurrence_counts.items() if v > 1]

    def _find_candidate_redundancies(self, candidates: Dict[Predicate, Set[Clause]]):
        """
            Finds all redundancies in refactoring candidates and adds them to the self._candidate_exclusion

        """
        if self.min_literals == self.max_literals:
            pass
        else:
            all_predicates = candidates.keys()
            for length in range(2, self.max_literals):
                for cmb in combinations(all_predicates, length):
                    cands = reduce((lambda x, y: x.union(y)), [candidates[p] for p in cmb])
                    cands = [x for x in cands if all([p in cmb for p in x.get_predicates()])]
                    cands_exact_length = [x for x in cands if len(x) == length]
                    cands_more_length = [x for x in cands if len(x) > length]

                    redundancies = [[x.get_head().get_predicate()] + [y.get_head().get_predicate() for y in cands_more_length if len(x.is_part_of(y))] for x in cands_exact_length]
                    redundancies = [x for x in redundancies if len(x) > 1]
                    if len(redundancies):
                        self.redundant_candidates += [tuple([p.get_name() for p in x]) for x in redundancies]

    def __create_var_map(self, model: cp_model.CpModel,
                         candidates: Set[Clause],
                         co_occurrences: Sequence[Sequence[str]],
                         clause_dependencies: Dict[str, Sequence[str]]):
        """
        Creates a CP-SAT variable for (1) each candidate clause and (2) an auxiliary variable for each combination of
        candidate clauses that appear in the encodings of clauses

        Also create the equivalences between aux variables and the original ones

        Args:
            model (CpModel): an instance of CP-SAT model
            candidates (Set[Clause]): a set of clauses defining latent predicates
            co_occurrences (List[Iterator[str]]): List of latent predicate that co occur in many encodings
                        each co-occurrence should be represented as a tuple of strings (names of predicates)

        Returns:
            Dict[Union[predicate_name, Tuple[predicate_names]], cp-sat variable]
        """
        variable_map = {}

        aux_var_index = 1

        for cand in candidates:
            # TODO: use entire clause as the variable key
            variable_map[cand.get_head().get_predicate().get_name()] = model.NewBoolVar(cand.get_head().get_predicate().get_name())

        for co in co_occurrences:
            variable_map[co] = model.NewBoolVar(f'aux{aux_var_index}')
            # create the equality relating the aux variable to a product of
            model.AddBoolAnd([variable_map[x] for x in co]).OnlyEnforceIf(variable_map[co])
            #model.AddMultiplicationEquality(variable_map[co], [variable_map[x] for x in co])

            # increase the index for the next aux var created
            aux_var_index += 1

        # add clause dependencies over different levels
        for cl in clause_dependencies:
            # add new var that will be true if all predicates from the body are selected
            b = model.NewBoolVar(f'aux_cldep_{self._get_candidate_index()}')
            model.AddBoolAnd([variable_map[c] for c in clause_dependencies[cl]]).OnlyEnforceIf(b)
            # selection of level+1 predicate implies selecting the predicates it depends on
            model.AddImplication(variable_map[cl], b)

        return variable_map

    def __impose_encoding_constraints(self, model: cp_model.CpModel,
                                      encodings: Dict[Clause, Sequence[ClausalTheory]],
                                      variable_map: Dict[Union[str, Iterator[str]], cp_model.IntVar]) -> Tuple[Dict[Clause, Sequence[cp_model.IntVar]], Dict[Clause, cp_model.IntVar]]:

        clause_level_selection_vars = {}
        encoding_clauses_to_vars = {}

        for clind, cl in enumerate(encodings):
            encs = encodings[cl]
            encs = [x.get_formulas() for x in encs]   # each item is the encoding level, as list of formulas

            clause_level_selection_vars[cl] = [model.NewBoolVar(f'aux_level_{x+1}_{self._get_candidate_index()}') for x in range(len(encs) + 1)] # + 1 to get 'choose not refactoring'
            level_components = []

            # individual_encodings = []

            for l_ind, level in enumerate(encs):
                individual_encodings_at_current_level = []

                for eind, en in enumerate(level):
                    plain_vars = sorted([a.get_predicate().get_name() for a in en.get_atoms()])

                    # find all sub-components that can be substituted with an aux variable from co-occurences
                    combs = []
                    for l in range(2, len(plain_vars)):
                        combs += list(combinations(plain_vars, l))

                    combs = [tuple(x) for x in combs if tuple(x) in variable_map]

                    # remove variables that are handled through the auxiliary variables
                    all_in_aux = set()
                    for aux in combs:
                        all_in_aux = all_in_aux.union(aux)

                    plain_vars = [x for x in plain_vars if x not in all_in_aux]

                    # add product to individual encodings
                    plain_vars = [variable_map[x] for x in plain_vars]
                    combs = [variable_map[x] for x in combs]

                    # ___ new encoding
                    tmp_var = model.NewBoolVar(f'ind_enc_{clind}_{l_ind+1}_{eind}')

                    # encoding with And/Or
                    # encodes one possible refactoring and adds them all together in individual_encodings_at_current_level
                    model.AddBoolAnd(plain_vars + combs).OnlyEnforceIf(tmp_var)
                    model.AddBoolOr([x.Not() for x in (plain_vars + combs)]).OnlyEnforceIf(tmp_var.Not())

                    individual_encodings_at_current_level.append(tmp_var)

                    # add the var to the corresponding clause
                    encoding_clauses_to_vars[encs[l_ind][eind]] = tmp_var

                # ENCODING WITH THE CURRENT LEVEL ONLY
                # takes individual encodings at the current level and makes an OR of all of them
                encoding_exists_var = model.NewBoolVar(f'aux_enc_exists_{self._get_candidate_index()}')
                model.AddBoolOr(individual_encodings_at_current_level).OnlyEnforceIf(encoding_exists_var)

                # And(level, Or(and individual encodings)) enforce only in entire_level_component (indicates that something from that level should be selected)
                level = clause_level_selection_vars[cl][l_ind+1] # l_ind = 0 is not refactoring
                entire_level_component = model.NewBoolVar(f'aux_levcom_{self._get_candidate_index()}')
                model.AddBoolAnd([level, encoding_exists_var]).OnlyEnforceIf(entire_level_component)
                level_components.append(entire_level_component)

            # at least one encoding has to be selected (or no encoding at all)
            if self.allow_no_refactoring:
                level_components += [clause_level_selection_vars[cl][0]]
            else:
                model.Add(clause_level_selection_vars[cl][0] == 0)

            if len(level_components):
                model.AddBoolOr(level_components)

            # exactly one encoding level has to be selected
            model.Add(sum(clause_level_selection_vars[cl]) == 1)

        return clause_level_selection_vars, encoding_clauses_to_vars

    def __eliminate_redundancy_in_solutions(self, model: cp_model.CpModel,
                                            redundancies: Dict[int, Dict[Sequence[str], Sequence[Clause]]],
                                            variable_map: Dict[Union[str, Iterator[str]], cp_model.IntVar],
                                            encoded_clause_vars: Dict[Clause, cp_model.IntVar],
                                            encoding_level_vars: Dict[Clause, Sequence[cp_model.IntVar]],
                                            reify: bool = False):

        to_return = []
        for level in redundancies:
            for redundancy_pattern in redundancies[level]:
                all_with_pattern = []
                for cl in redundancies[level][redundancy_pattern]:
                    # + 1 because level=0 is no refactoring
                    corresponding_level_var = encoding_level_vars[cl.get_property("parent")][level + 1]
                    b = model.NewBoolVar(f'aux_red_{self._get_candidate_index()}')
                    model.AddBoolAnd([corresponding_level_var, encoded_clause_vars[cl]]).OnlyEnforceIf(b)
                    model.AddBoolOr([corresponding_level_var.Not(), encoded_clause_vars[cl].Not()]).OnlyEnforceIf(b.Not())
                    all_with_pattern.append(b)

                if reify:
                    if self.minimise_redundancy_absolute_count:
                        if self.equals_zero is None:
                            self.equals_zero = model.NewBoolVar('equals_zero')
                            model.Add(self.equals_zero == 0)

                        out_b = model.NewIntVar(-1, len(all_with_pattern), f'aux_red_sum_{self._get_candidate_index()}')
                        model.Add((sum(
                            all_with_pattern) - 1) == out_b)  # -1 allows to use 1 of the potentially redundant clauses, if only 1 is used there is no redundancy
                        b_max = model.NewBoolVar(f'aux_redmax_{self._get_candidate_index()}')
                        model.AddMaxEquality(b_max, [self.equals_zero, out_b])
                        to_return.append(b_max)
                    else:
                        out_b = model.NewBoolVar(f'aux_red_sum_{self._get_candidate_index()}')
                        model.Add(sum(all_with_pattern) <= 1).OnlyEnforceIf(
                            out_b.Not())  # reasoning inverted because out_b=0 means no redundancy
                        model.Add(sum(all_with_pattern) > 1).OnlyEnforceIf(out_b)
                        to_return.append(out_b)
                else:
                    model.Add(sum(all_with_pattern) <= 1)

        return to_return

    def __eliminate_candidate_alternatives(self, model: cp_model.CpModel,
                                           variable_map: Dict[Union[str, Iterator[str]], cp_model.IntVar]):
        """
        Eliminates candidate alternatives:
            when multiple clause have the same body, but different head variables
            imposes the constaint that at most one of those can be selected


        Args:
            model (cp_model.CpModel): model
            variable_map (Dict[Union[str, Iterator[str]], cp_model.IntVar]): mapping from clauses to cp_model.vars
        """
        for alt in self._candidate_exclusion:
            model.Add(sum([variable_map[x] for x in alt]) <= 1)

    def __eliminate_redundant_candidates(self, model: cp_model.CpModel,
                                         variable_map: Dict[Union[str, Iterator[str]], cp_model.IntVar],
                                         reify: bool = False):
        """
        Eliminates redundant candidates in the solution (imposes the same constraint __eliminate_candidate_alternatives)

        """
        to_return = []
        for alt in self.redundant_candidates:
            # model.AddBoolOr([variable_map[x].Not() for x in alt])
            if reify:
                b = model.NewBoolVar(f'aux_cr_{self._get_candidate_index()}')
                model.Add(sum([variable_map[x] for x in alt]) <= 1).OnlyEnforceIf(b.Not())
                model.Add(sum([variable_map[x] for x in alt]) > 1).OnlyEnforceIf(b)
                to_return.append(b)
            else:
                model.Add(sum([variable_map[x] for x in alt]) <= 1)

        return to_return

    def __set_objective(self, model: cp_model.CpModel,
                        candidates: Set[Clause],
                        variable_map: Dict[Union[str, Iterator[str]], cp_model.IntVar],
                        redundancies: Dict[int, Dict[Sequence[str], Sequence[Clause]]],
                        encoded_clause_vars: Dict[Clause, cp_model.IntVar],
                        encoding_level_vars: Dict[Clause, Sequence[cp_model.IntVar]],
                        encodings: Dict[Clause, Sequence[ClausalTheory]]):

        individual_redunds = []
        if self.minimise_redundancy and self.prevent_redundancies:
            individual_redunds += self.__eliminate_redundancy_in_solutions(model, redundancies, variable_map, encoded_clause_vars, encoding_level_vars, reify=True)

        if self.minimise_redundancy and self.exclude_redundant_candidates:
            individual_redunds += self.__eliminate_redundant_candidates(model, variable_map, reify=True)

        if self._objective_type == NUM_PREDICATES:
            vars_to_use = [x.get_head().get_predicate().get_name() for x in candidates]
            vars_to_use = [variable_map[x] for x in vars_to_use]

            if self.minimise_redundancy:
                model.Minimize(reduce((lambda x, y: x + y), vars_to_use + individual_redunds))
            else:
                model.Minimize(reduce((lambda x, y: x + y), vars_to_use))

        elif self._objective_type == NUM_LITERALS:
            all_weighted_clauses = []
            # lengths of selected clauses
            for cl in encodings:
                for ind, eth in enumerate(encodings[cl]):
                    wcl = [(x, len(x) + 1) for x in eth.get_formulas()]  # + 1 to include the head predicate

                    level = encoding_level_vars[cl][ind+1]
                    for f, cost in wcl:
                        b = model.NewBoolVar(f'aux_and_{self._get_candidate_index()}')
                        model.AddBoolAnd([level, encoded_clause_vars[f]]).OnlyEnforceIf(b)
                        model.AddBoolOr([level.Not(), encoded_clause_vars[f].Not()]).OnlyEnforceIf(b.Not())
                        all_weighted_clauses.append(b*cost)

                # add no refactoring cost, encoding/refactoring level = 0
                if self.allow_no_refactoring:
                    all_weighted_clauses.append(encoding_level_vars[cl][0]*(len(cl) + 1))

            # lengths of selected candidates
            # exclude 1-length candidates because they help with partial refactoring:
            #                   the heads can simply be replaced by the body
            candidate_lengths = [(x.get_head().get_predicate().get_name(), len(x) + 1) for x in candidates if len(x) > 1]
            candidate_lengths = [variable_map[k]*v for k, v in candidate_lengths]

            if self.minimise_redundancy:
                model.Minimize(reduce((lambda x, y: x + y), all_weighted_clauses + candidate_lengths + individual_redunds))
            else:
                model.Minimize(
                    reduce((lambda x, y: x + y), all_weighted_clauses + candidate_lengths))

        else:
            raise Exception(f'unknown objective function {self._objective_type}')

    def _map_to_solver_and_solve(self, candidates: Set[Clause],
                                 encodings: Dict[Clause, Sequence[ClausalTheory]],
                                 redundancies: Dict[int, Dict[Sequence[str], Sequence[Clause]]],
                                 cooccurrences: Sequence[Sequence[str]],
                                 clause_dependencies: Dict[str, Sequence[str]],
                                 max_predicates,
                                 num_threads,
                                 max_time_s):
        """
        Maps the refactoring problem to CP-SAT and solves it

        Args:
            candidates (Set[Clause]): refactoring candidates
            encodings (Dict[Clause, Sequence[ClausalTheory]]): possible encodings of each a clause, per level
            redundancies (Dict[int, Dict[Sequence[str], Sequence[Clause]]]): redundandies per level
                                Dict[key: encoding level
                                     value: Dict[key: redundancy pattern (sequence of predicate names)
                                                 val: Sequence[Clauses] with the redundancy]

            cooccurrences (Sequence[Sequence[str]]):
                            tuples of predicate variables that often co-occur and can be replaced with a single variable
            clause_dependencies (Dict[str, Sequence[str]]): dependence of predicates over different encoding levels

        """

        self._logger.info(f'Mapping to CP and solving')

        model = cp_model.CpModel()
        variable_map = self.__create_var_map(model, candidates, cooccurrences, clause_dependencies)
        cls_level_indicators, encoded_cls_var = self.__impose_encoding_constraints(model, encodings, variable_map)

        if self.exclude_alternatives:
            self.__eliminate_candidate_alternatives(model, variable_map)

        if self.exclude_redundant_candidates and not self.minimise_redundancy:
            self.__eliminate_redundant_candidates(model, variable_map)

        if self.prevent_redundancies and not self.minimise_redundancy:
            # if we want to eliminate redundancy and we are minimizing the number of predicates
            self.__eliminate_redundancy_in_solutions(model, redundancies, variable_map, encoded_cls_var, cls_level_indicators)
        self.__set_objective(model, candidates, variable_map, redundancies if self.minimise_redundancy else (), encoded_cls_var, cls_level_indicators, encodings)

        if max_predicates:
            model.Add(reduce((lambda x, y: x + y), [variable_map[x.get_head().get_predicate().get_name()] for x in candidates]) <= max_predicates)

        solver = cp_model.CpSolver()
        solver.parameters.num_search_workers = num_threads
        if max_time_s:
            solver.parameters.max_time_in_seconds = max_time_s

        solution_callback = VarArraySolutionPrinter([variable_map[x.get_head().get_predicate().get_name()] for x in candidates], self._logger)
        self._logger.info("Started solving")
        status = solver.SolveWithSolutionCallback(model, solution_callback)  # solver.Solve(model)
        self._logger.info(f"Solving done; status: {status}")

        if status in (cp_model.OPTIMAL, cp_model.FEASIBLE, cp_model.UNKNOWN):
            selected_clauses = set([k for k, v in variable_map.items() if isinstance(k, str) and solver.Value(v) == 1])
            selected_clauses = [x for x in candidates if x.get_head().get_predicate().get_name() in selected_clauses]
            refactoring_steps_per_clause = {}
            for cl in cls_level_indicators:
                tmp = [solver.Value(x) for x in cls_level_indicators[cl]]
                refactoring_steps_per_clause[cl] = tmp.index(1)  # + 1 - not needed because index  would mean 1 step of refactoring
            return selected_clauses, refactoring_steps_per_clause
        else:
            raise Exception('Could not find a satisfiable solution!')

    def _prepare_final_theory(self, clauses: ClausalTheory,
                              refactoring_predicates: Dict[Predicate, Set[Clause]],
                              refactoring_steps: Dict[Clause, int]) -> ClausalTheory:
        """
        Produces the final refactored theory

        Args:
            clauses (ClausalTheory): theory to refactor
            refactoring_predicates (Dict[Predicate, Set[Clause]]): encoding predicates to use
            refactoring_steps (Dict[Clause, int]]): number of refatoring steps for each clause in the theory

        Returns:
            refactorized theory

        """
        self._logger.setLevel(logging.CRITICAL)
        final_theory = list(reduce((lambda x, y: x.union(y)), [[p for p in x if len(p) > 1] for x in refactoring_predicates.values()], set()))

        # resolve single literal clauses
        single_body_cands = list(reduce((lambda x, y: x.union(y)), [[p for p in c if len(p) == 1] for c in refactoring_predicates.values()], set()))
        single_mapping = dict([(x.get_head().get_predicate(), list(x.get_predicates())[0]) for x in single_body_cands])
        while any([x in single_mapping for x in single_mapping.values()]):
            for item in single_mapping:
                if single_mapping[item] in single_mapping:
                    single_mapping[item] = single_mapping[single_mapping[item]]

        for cl in clauses.get_formulas():
            steps = refactoring_steps[cl]
            tmp_frm = cl

            while steps > 0:
                if not isinstance(tmp_frm, list):
                    tmp_frm = [tmp_frm]
                re_frm = []
                if len(tmp_frm) > 1:
                    for itm in tmp_frm:
                        try:
                            re_frm += self._encode_theory([itm], refactoring_predicates).values()
                        except Exception:
                            pass
                else:
                    re_frm = self._encode_theory(tmp_frm, refactoring_predicates)
                    re_frm = [x for x in re_frm.values()]
                re_frm = reduce((lambda x, y: x + y), re_frm)

                tmp_frm = [x for x in re_frm]
                steps -= 1

            if not isinstance(tmp_frm, list):
                tmp_frm = [tmp_frm]

            final_theory += tmp_frm

        # if any atoms refer to single literal clause
        new_frms = []
        for frm_itm in final_theory:
            if any([x in single_mapping for x in frm_itm.get_predicates()]):
                tmp_head = frm_itm.get_head()
                tmp_body = []
                for atm in frm_itm.get_atoms():
                    if atm.get_predicate() in single_mapping:
                        tmp_body.append(c_literal(single_mapping[atm.get_predicate()], atm.get_terms()))
                    else:
                        tmp_body.append(atm)

                new_frms.append(Clause(tmp_head, tmp_body))
            else:
                new_frms.append(frm_itm)

        self._logger.setLevel(self.log_level)

        return ClausalTheory(new_frms)

    def restructure(self, clauses: ClausalTheory, max_layers=None, max_predicate=None, num_threads=1, max_time_s=None,
                    prune_candidates=False):
        """
        Starts the restructuring process

        Args:
            clauses: a theory to restructure

        Return:
            a new restructured theory
        """
        self.aux_candidate_counter = 0
        self.count_candidates = 0
        candidatesPruned = set()

        # 4 -- optimal 2 -- feasible  0 -- unknown  3 -- infeasible
        # print(cp_model.OPTIMAL, cp_model.FEASIBLE, cp_model.UNKNOWN, cp_model.INFEASIBLE)

        encodings_space: Dict[Clause, List[ClausalTheory]] = dict([(f, []) for f in clauses.get_formulas()])
        all_refactoring_candidates: Dict[Predicate, Set[Clause]] = {}
        all_redundancies = {}
        # ^-  Dict[ key: encoding level, to be used to select the appropriate encoding level var )
        #           val: Dict[ key: redundancy string (tuple)
        #                      val: encoded clauses Sequence[Clause]       ] ]
        all_cooccurences = []
        clause_dependencies = {}

        something_to_refactor: bool = True
        iteration_counter = 0

        while something_to_refactor:
            self.candidate_usage_count = {}
            self.enumerated_body_signatures = {}
            self._logger.info(f"\tStarting iteration: {iteration_counter}")
            # collect clauses to focus on
            if iteration_counter == 0:
                focus_clauses = list(encodings_space.keys())
            else:
                focus_clauses = reduce((lambda x, y: x + y),
                                       [encodings_space[x][iteration_counter-1].get_formulas() for x in encodings_space if len(encodings_space[x]) == iteration_counter], [])
            focus_clauses = [x for x in focus_clauses if len(x) >= self.min_literals]

            iteration_candidates = self._get_candidates(focus_clauses)

            #self._find_candidate_redundancies(iteration_candidates)
            # save the current candidates to the global collection
            # all_refactoring_candidates.update(iteration_candidates)

            if iteration_counter > 0:
                for p in iteration_candidates:
                    for cl in iteration_candidates[p]:
                        head_p = cl.get_head().get_predicate().get_name()
                        dep_ps = [x.get_predicate().get_name() for x in cl.get_atoms()]
                        if head_p not in clause_dependencies:
                            clause_dependencies[head_p] = dep_ps

            self._logger.info(f"\t\tfound {self.count_candidates} candidates")

            iteration_formulas = {}

            # extend the encoding of each original clause with the new layer of encodings
            if iteration_counter == 0:
                encoded_clauses = self._encode_theory(clauses, iteration_candidates)
                #iteration_formulas.update(encoded_clauses)
                for cl in focus_clauses:
                    frms_to_add = [v for v in encoded_clauses[cl]]
                    if len(frms_to_add):
                        encodings_space[cl].append(ClausalTheory(frms_to_add))
            else:
                for cl in encodings_space:
                    if len(encodings_space[cl]) == iteration_counter:
                        encoded_clauses = self._encode_theory([x for x in encodings_space[cl][iteration_counter-1].get_formulas() if len(x) >= self.min_literals], iteration_candidates, originating_clause=cl)
                        if len(encoded_clauses) == 0:
                            continue
                        #iteration_formulas.update(encoded_clauses)
                        # add encodings of all of the clauses
                        frms_to_add = reduce((lambda x, y: x + y), [v for k, v in encoded_clauses.items()], [])
                        if len(frms_to_add):
                            encodings_space[cl].append(ClausalTheory(frms_to_add))
                    else:
                        pass

            # if pruning is required
            # has to be done after the encoding as that is where the counts happen
            if prune_candidates:
                iteration_candidates, rejectedCandidates = self._prune_candidate_set(iteration_candidates)
                rejectedPredicates = set(sorted([x.get_head().get_predicate() for x in rejectedCandidates], key=lambda x: str(x)))
                false_exclusions = set()
                for cl in encodings_space:
                    if len(encodings_space[cl]) > iteration_counter:
                        formulas_to_remove = encodings_space[cl][-1].get_formulas(rejectedPredicates)

                        # if no refactoring is left after removing rejected predicates,
                        #       retain the rejected predicates that were used
                        if len(formulas_to_remove) == len(encodings_space[cl][-1]):
                            used_preds = reduce((lambda x, y: x.union(y)), [x.get_predicates() for x in formulas_to_remove], set())
                            false_exclusions = false_exclusions.union(rejectedPredicates.intersection(used_preds))

                # add false rejections to the iterations candidates
                matching_falsely_rejected_candidates = [x for x in rejectedCandidates if x.get_head().get_predicate() in false_exclusions]
                for item in matching_falsely_rejected_candidates:
                    for p in item.get_predicates():
                        iteration_candidates[p].add(item)

                rejectedPredicates = rejectedPredicates.difference(false_exclusions)
                candidatesPruned = candidatesPruned.union(rejectedCandidates.difference(matching_falsely_rejected_candidates))
                all_refactoring_candidates.update(iteration_candidates)

                # clean the refactored theories
                for cl in encodings_space:
                    if len(encodings_space[cl]) > iteration_counter:
                        encodings_space[cl][-1].remove_formulas_with_predicates(rejectedPredicates)
                        iteration_formulas[cl] = encodings_space[cl][-1].get_formulas()

                # clear the clause dependencies
                for rej_can in rejectedPredicates:
                    if rej_can.get_name() in clause_dependencies:
                        del clause_dependencies[rej_can.get_name()]

                # clear alternatives
                rejectedPredicates = set([x.get_name() for x in rejectedPredicates])
                self._candidate_exclusion = [x for x in self._candidate_exclusion if not any([p in rejectedPredicates for p in x])]
            else:
                all_refactoring_candidates.update(iteration_candidates)
                for cl in encodings_space:
                    if len(encodings_space[cl]) > iteration_counter:
                        iteration_formulas[cl] = encodings_space[cl][-1].get_formulas()

            # find candidate redundancies
            if self.exclude_redundant_candidates:
                self._logger.info("\t Finding redundancies amongst candidates")
                self._find_candidate_redundancies(iteration_candidates)
                self._logger.info("\t\t\t done!")

            if self.prevent_redundancies:
                # detect all redundancies and co-occurences
                tmp_redundancies, tmp_cooccurrences = self._find_redundancies(iteration_formulas)
            #     all_cooccurences += tmp_cooccurrences
                if len(tmp_redundancies):
                    all_redundancies[iteration_counter] = tmp_redundancies

            iteration_counter += 1

            if iteration_counter == max_layers or len(focus_clauses) == 0:
                something_to_refactor = False

        distinct_candidates = set()
        for p in all_refactoring_candidates:
            distinct_candidates = distinct_candidates.union(all_refactoring_candidates[p])

        self._logger.info(f"Found {self.count_candidates} candidates in total; pruned {len(candidatesPruned)}")

        selected_clauses, refactoring_steps = self._map_to_solver_and_solve(distinct_candidates, encodings_space,
                                                                            all_redundancies, all_cooccurences, clause_dependencies,
                                                                            max_predicate, num_threads, max_time_s)

        # create_clause_index
        cl_ind = {}
        for cl in selected_clauses:
            pps = cl.get_predicates()
            for p in pps:
                if p not in cl_ind:
                    cl_ind[p] = set()
                cl_ind[p].add(cl)

        final_theory = self._prepare_final_theory(clauses, cl_ind, refactoring_steps)

        return selected_clauses, final_theory


class VarArraySolutionPrinter(cp_model.CpSolverSolutionCallback):
    """Print intermediate solutions."""

    def __init__(self, variables, logger=None):
        cp_model.CpSolverSolutionCallback.__init__(self)
        self.__variables = variables
        self.__solution_count = 0
        self._logger = logger

    def on_solution_callback(self):
        self.__solution_count += 1
        if self._logger:
            self._logger.info(f"\tIteration {self.__solution_count}: objective {self.ObjectiveValue()}, selected {sum([1 for x in self.__variables if self.Value(x) == 1])}")
        else:
            print(f"\tIteration {self.__solution_count}: objective {self.ObjectiveValue()}, selected {sum([1 for x in self.__variables if self.Value(x) == 1])} \t\t[{datetime.datetime.now()}]")

    def solution_count(self):
        return self.__solution_count


class Stevie:

    def __init__(self, clauses: ClausalTheory, invented_predicates_name: str = "ho"):
        self._clauses = clauses
        self._candidate_abstractions = {}
        self._invented_index = 1
        self._invented_predicate_names = set()
        self._higher_order_var = None
        self._inv_predicates_name = invented_predicates_name

    def _get_cannonical_form(self, lits: Sequence[Literal], h_var_index: Dict[SecondOrderVariable, int], variables: Sequence[Variable] = None):
        cannonical = []
        vars = reduce(lambda x, y: x + y, [a.get_variables() for a in lits], [])
        vars = reduce(lambda x, y: x + [y] if y not in x else x, vars, [])
        vars = sorted(vars, key=lambda x: x.name)
        var_index = dict([(v, ind) for ind, v in enumerate(vars)])

        costs = {}  # costs of each predicate in terms of the variables
        max_arity = max(list(map(lambda x: len(x.get_variables()), lits)))

        for cl_b in lits:
            if isinstance(cl_b, Not):
                pred_name = "not "
                lit_to_use = cl_b.get_formula()
            else:
                pred_name = ""
                lit_to_use = cl_b

            pred = lit_to_use.get_predicate()
            if pred.get_name() in self._invented_predicate_names:
                pred_name += "I"
            elif isinstance(pred, SecondOrderVariable):
                pred_name += str(h_var_index.get(pred, 1))
            else:
                pred_name += pred.get_name()

            b = f"{pred_name}({','.join([str(var_index[x]) for x in lit_to_use.get_variables()])})"
            cannonical.append(b)

            #calculate cost
            var_order = lit_to_use.get_variables()
            var_order = list(map(lambda x: var_index[x] + 1, var_order))
            costs[b] = sum( map(lambda x: var_order[x]*(10**(max_arity - x))*(len(vars) + 1), range(0, len(var_order))) )

        cannonical = list(sorted(cannonical, key=lambda x: costs[x]))
        if variables:
            return [var_index[x] for x in variables], cannonical
        else:
            return cannonical

    def _format_final_cannon(self, cannon_rep_per_clause):
        head_vars_c = [x[0] for x in cannon_rep_per_clause]
        head_var_signatures = {}
        for hv_i in range(len(head_vars_c[0])):
            head_var_signatures[hv_i] = '/'.join([str(x[hv_i]) for x in head_vars_c])
        head_vars_c = f"({','.join([head_var_signatures[x] for x in head_var_signatures.keys()])})"
        cannon = [','.join(x[1]) for x in cannon_rep_per_clause]

        return head_vars_c + " " + "/".join([str(x) for x in cannon])

    def _get_new_name(self):
        self._invented_index += 1
        name = f"{self._inv_predicates_name}_{self._invented_index - 1}"
        self._invented_predicate_names.add(name)
        return name

    def _decrease_invented_counter(self, decrement=1):
        self._invented_index -= decrement

    def _add_clause_to_candidate_pool(self, cannonical_representation: str, higher_order_clause: Union[Clause, Disjunction, Recursion], clause: Union[Clause, Disjunction, Recursion], binding: Dict):
        if cannonical_representation not in self._candidate_abstractions:
            self._candidate_abstractions[cannonical_representation] = {}
            self._candidate_abstractions[cannonical_representation]['cand'] = higher_order_clause
            self._candidate_abstractions[cannonical_representation]['dependents'] = []
            self._candidate_abstractions[cannonical_representation]['dependents'].append({'cl': clause, 'bind': binding})
        else:
            self._candidate_abstractions[cannonical_representation]['dependents'].append({'cl': clause, 'bind': binding})

    def _abstract_literals_in_clause(self,
                                     clause: Clause,
                                     literals_to_abstract: Sequence[Literal],
                                     literals_to_hvar_map: Dict[Literal, SecondOrderVariable],
                                     new_head_predicate: Predicate):
        higher_order_var_order = [literals_to_hvar_map[x] for x in literals_to_abstract]

        cl_head = clause.get_head()
        cl_body = clause.get_atoms()

        new_cl_head = Literal(new_head_predicate, cl_head.get_terms() + higher_order_var_order)

        # first take care of recursive preds
        if clause.is_recursive():
            cl_body = [Literal(new_head_predicate, x.get_terms() + higher_order_var_order) if x.get_predicate() == cl_head.get_predicate() else x for x in cl_body]
        new_cl_body = []

        # abstract each literal:
        for lit in cl_body:
            if lit.get_predicate() == new_head_predicate:
                new_cl_body.append(lit)
                continue

            is_negated = False
            if isinstance(lit, Not):
                is_negated = True
                lit_to_use = lit.get_formula()
            else:
                lit_to_use = lit

            if lit_to_use not in literals_to_hvar_map:
                new_cl_body.append(lit)
            else:
                new_lit = Literal(literals_to_hvar_map[lit_to_use], lit_to_use.get_terms())

                if is_negated:
                    new_cl_body.append(Not(new_lit))
                else:
                    new_cl_body.append(new_lit)

        return Clause(new_cl_head, new_cl_body)

    def _abstract_predicates_in_clause(self,
                                       clause: Clause,
                                       predicates_to_abstract: Sequence[Predicate],
                                       predicate_substitutions: Dict[Predicate, SecondOrderVariable],
                                       new_head_predicate: Predicate
                                       ):
        higher_order_var_order = [predicate_substitutions[p] for p in predicates_to_abstract]

        cl_head = clause.get_head()
        cl_body = clause.get_atoms()

        new_cl_head = Literal(new_head_predicate, cl_head.get_terms() + higher_order_var_order)

        # first take care of recursive preds
        cl_body = [Literal(new_head_predicate,
                           x.get_terms() + higher_order_var_order) if x.get_predicate() == cl_head.get_predicate() else x
                   for x in cl_body]

        new_cl_body = []

        # abstract predicate in each literal
        for lit in cl_body:
            if lit.get_predicate() == new_head_predicate:
                new_cl_body.append(lit)
                continue

            is_negated = False
            if isinstance(lit, Not):
                lit_to_use = lit.get_formula()
                is_negated = True
            else:
                lit_to_use = lit

            if lit.get_predicate() not in predicate_substitutions:
                new_cl_body.append(lit)
            else:
                new_lit = Literal(predicate_substitutions[lit_to_use.get_predicate()], lit_to_use.get_terms())

                if is_negated:
                    new_cl_body.append(Not(new_lit))
                else:
                    new_cl_body.append(new_lit)

        return Clause(new_cl_head, new_cl_body)

    def _abstract_literal_in_definition(self, definition: Union[Disjunction,Recursion],
                                        literals_to_abstract: Sequence[Literal],
                                        literals_to_hvar_map: Dict[Literal, SecondOrderVariable],
                                        new_head_predicate: Predicate,
                                        limit_to_clause: Sequence[int] = None):
        if limit_to_clause is None:
            limit_to_clause = set(range(len(definition)))

        abstracted_clauses = []
        for ind, cl in enumerate(definition.get_clauses()):
            if ind in limit_to_clause:
                abstracted_clauses.append(self._abstract_literals_in_clause(cl, literals_to_abstract, literals_to_hvar_map, new_head_predicate))
            else:
                abstracted_clauses.append(self._abstract_literals_in_clause(cl, [], {}, new_head_predicate))

        if isinstance(definition, Disjunction):
            return Disjunction(abstracted_clauses)
        else:
            return Recursion(abstracted_clauses)

    def _abstract_predicates_in_definition(self, definition: Union[Disjunction,Recursion],
                                        predicate_to_abstract: Sequence[Predicate],
                                        predicate_to_hvar_map: Dict[Predicate, SecondOrderVariable],
                                        new_head_predicate: Predicate,
                                        limit_to_clause: Sequence[int] = None):
        if limit_to_clause is None:
            limit_to_clause = set(range(len(definition)))

        abstracted_clauses = []
        for ind, cl in enumerate(definition.get_clauses()):
            if ind in limit_to_clause:
                abstracted_clauses.append(
                    self._abstract_predicates_in_clause(cl, predicate_to_abstract, predicate_to_hvar_map,
                                                       new_head_predicate))
            else:
                abstracted_clauses.append(self._abstract_predicates_in_clause(cl, [], {}, new_head_predicate))

        if isinstance(definition, Disjunction):
            return Disjunction(abstracted_clauses)
        else:
            return Recursion(abstracted_clauses)

    def _determine_predicate_order(self, clause: Union[Clause,Disjunction,Recursion], predicates: Set[Predicate]):
        if isinstance(clause, Clause):
            clauses = [clause]
        else:
            clauses = clause.get_clauses()

        pred_index = {}
        for ind, cl in enumerate(clauses):
            for lit_ind, lit in enumerate(cl.get_atoms()):
                p = lit.get_predicate()
                if p in predicates and p not in pred_index:
                    pred_index[p] = ind*10 + lit_ind

        return pred_index

    def _extract_candidates_new(self, max_predicate_to_abstract=1, min_predicates_to_abstract=1):
        pure_clauses = [x for x in self._clauses.get_formulas() if isinstance(x, Clause)]
        disjunctions = [x for x in self._clauses.get_formulas() if isinstance(x, Disjunction)]
        recursions = [x for x in self._clauses.get_formulas() if isinstance(x, Recursion)]

        pure_clauses = [alphabeticiseClausalConstruct(r, from_pred_name=False) for r in pure_clauses]
        disjunctions = [alphabeticiseClausalConstruct(r, from_pred_name=False) for r in disjunctions]
        recursions = [alphabeticiseClausalConstruct(r, from_pred_name=False) for r in recursions]

        higher_order_variables = [chr(x) for x in range(ord('P'), ord('P') + max_predicate_to_abstract)]
        higher_order_variables = [c_hvar(n) for n in higher_order_variables]

        # get candidates from clauses
        for cl_ind in range(len(pure_clauses)):
            clause = pure_clauses[cl_ind]
            all_predicates = clause.get_predicates()

            # enumerate all subsets of the body literals
            for l in range(min_predicates_to_abstract, max_predicate_to_abstract+1):
                for comb in combinations(all_predicates, l):
                    comb = list(comb)
                    predicate_order = self._determine_predicate_order(clause, set(comb))
                    comb = sorted(comb, key=lambda x: predicate_order[x])
                    predicate_to_hvar_map = dict([(p, v) for p, v in zip(comb, higher_order_variables)])

                    # add these predicates as head variables
                    new_head_args = clause.get_head().get_terms() + [predicate_to_hvar_map[x] for x in comb]
                    new_head_pred = c_pred(self._get_new_name(), len(new_head_args), [x.get_type() for x in new_head_args])

                    # compute cannonical representation of the abstracted clause
                    #               (string used to determine whether we have already seen this abstracted clause)
                    hvar_to_ind_map = dict([(predicate_to_hvar_map[v], ind) for ind, v in enumerate(comb)])
                    abstracted_clause = self._abstract_predicates_in_clause(clause, comb, predicate_to_hvar_map, new_head_pred)
                    head_vars_cannon, cannon = self._get_cannonical_form(abstracted_clause.get_atoms(), hvar_to_ind_map, [v for v in abstracted_clause.get_head().get_terms() if not isinstance(v, SecondOrderVariable)])
                    cannon = f"({','.join([str(x) for x in head_vars_cannon])}) {','.join(cannon)}"

                    # remember how to replace higher order variables in this clause
                    hvar_to_pred = dict([(v, k) for k, v in predicate_to_hvar_map.items()])

                    if cannon in self._candidate_abstractions:
                        self._decrease_invented_counter()
                        self._add_clause_to_candidate_pool(cannon, None, clause, hvar_to_pred)
                    else:
                        self._add_clause_to_candidate_pool(cannon, abstracted_clause, clause, hvar_to_pred)

        # get candidates from disjunctions
        for dis_ind in range(len(disjunctions)):
            current_disjunction = disjunctions[dis_ind]
            all_predicates = current_disjunction.get_predicates()

            for l in range(min_predicates_to_abstract, max_predicate_to_abstract + 1):
                for comb in combinations(all_predicates, l):
                    comb = list(comb)
                    predicate_order = self._determine_predicate_order(current_disjunction, set(comb))
                    comb = sorted(comb, key=lambda x: predicate_order[x])
                    predicate_to_hvar_map = dict([(p, v) for p, v in zip(comb, higher_order_variables)])

                    new_head_args = current_disjunction.get_head()[0].get_terms() + [predicate_to_hvar_map[x] for x in comb]
                    new_head_pred = c_pred(self._get_new_name(), len(new_head_args), [x.get_type() for x in new_head_args])

                    # compute cannonical representation of the abstracted clause
                    #               (string used to determine whether we have already seen this abstracted clause)
                    hvar_to_ind_map = dict([(predicate_to_hvar_map[v], ind) for ind, v in enumerate(comb)])
                    abstracted_disjunction = self._abstract_predicates_in_definition(current_disjunction, comb, predicate_to_hvar_map, new_head_pred)

                    cannon = [self._get_cannonical_form(x.get_atoms(), hvar_to_ind_map, variables=[v for v in x.get_head().get_terms() if not isinstance(v, SecondOrderVariable)]) for x in abstracted_disjunction.get_clauses()]
                    cannon = self._format_final_cannon(cannon)

                    # remember how to replace higher order variables in this clause
                    hvar_to_pred = dict([(v, k) for k, v in predicate_to_hvar_map.items()])

                    if cannon in self._candidate_abstractions:
                        self._decrease_invented_counter()
                        self._add_clause_to_candidate_pool(cannon, None, current_disjunction, hvar_to_pred)
                    else:
                        self._add_clause_to_candidate_pool(cannon, abstracted_disjunction, current_disjunction, hvar_to_pred)

        for rec_idn in range(len(recursions)):
            current_recursion = recursions[rec_idn]
            head_pred = current_recursion.get_head()[0].get_predicate()
            all_predicates = [x for x in current_recursion.get_predicates() if x != head_pred]

            for l in range(min_predicates_to_abstract, max_predicate_to_abstract + 1):
                for comb in combinations(all_predicates, l):
                    comb = list(comb)
                    predicate_order = self._determine_predicate_order(current_recursion, set(comb))
                    comb = sorted(comb, key=lambda x: predicate_order[x])
                    predicate_to_hvar_map = dict([(p, v) for p, v in zip(comb, higher_order_variables)])

                    new_head_args = current_recursion.get_head()[0].get_terms() + [predicate_to_hvar_map[x] for x in comb]
                    new_head_pred = c_pred(self._get_new_name(), len(new_head_args), [x.get_type() for x in new_head_args])

                    # compute cannonical representation of the abstracted clause
                    #               (string used to determine whether we have already seen this abstracted clause)
                    hvar_to_ind_map = dict([(predicate_to_hvar_map[v], ind) for ind, v in enumerate(comb)])
                    abstracted_recursion = self._abstract_predicates_in_definition(current_recursion, comb,
                                                                                     predicate_to_hvar_map,
                                                                                     new_head_pred)

                    cannon = [
                        self._get_cannonical_form(x.get_atoms(), hvar_to_ind_map, variables=[v for v in x.get_head().get_variables() if not isinstance(v, SecondOrderVariable)])
                        for x in abstracted_recursion.get_clauses()]
                    cannon = self._format_final_cannon(cannon)

                    # remember how to replace higher order variables in this clause
                    hvar_to_pred = dict([(v, k) for k, v in predicate_to_hvar_map.items()])

                    if cannon in self._candidate_abstractions:
                        self._decrease_invented_counter()
                        self._add_clause_to_candidate_pool(cannon, None, current_recursion, hvar_to_pred)
                    else:
                        self._add_clause_to_candidate_pool(cannon, abstracted_recursion, current_recursion, hvar_to_pred)

    
    def _extract_candidates(self):
        """
        Currently only abstracts one predicate per
        :return:
        """
        pure_clauses = [x for x in self._clauses.get_formulas() if isinstance(x, Clause)]
        disjunctions = [x for x in self._clauses.get_formulas() if isinstance(x, Disjunction)]
        recursions = [x for x in self._clauses.get_formulas() if isinstance(x, Recursion)]

        high_order_var = SecondOrderVariable('R')
        self._higher_order_var = high_order_var

        # get candidates from clauses
        for cl_ind in range(len(pure_clauses)):
            # transform to higher_order clause
            body_literals = pure_clauses[cl_ind].get_atoms()
            for lit in body_literals:
                high_lit = Literal(high_order_var, lit.get_terms())
                new_body_lits = [high_lit if x == lit else x for x in body_literals]

                head_vars_can, cannon = self._get_cannonical_form(new_body_lits, {high_order_var: 1}, variables=pure_clauses[cl_ind].get_head().get_terms())
                cannon = f"({','.join([str(x) for x in head_vars_can])}) {','.join(cannon)}"

                if cannon in self._candidate_abstractions:
                    # if there already exists an abstraction of the same form
                    # simply say that
                    self._add_clause_to_candidate_pool(cannon, None, pure_clauses[cl_ind], {high_order_var: lit.get_predicate()})
                else:
                    head_args = pure_clauses[cl_ind].get_head().get_terms() + [high_order_var]
                    head_types = [x.get_type() for x in head_args]
                    new_head_lit = Literal(c_pred(self._get_new_name(), len(head_args), head_types), head_args)
                    h_cl = Clause(new_head_lit, new_body_lits)

                    self._add_clause_to_candidate_pool(cannon, h_cl, pure_clauses[cl_ind], {high_order_var: lit.get_predicate()})

        # disjunctions
        for dis_ind in range(len(disjunctions)):
            clauses = disjunctions[dis_ind].get_clauses()
            clauses = sorted(clauses, key=lambda x: str(x))

            # consider abstracting literals in each clause
            for cl in clauses:
                # transform the individual clause to higher-order versions, make sure that everything else is done with the entire disjunction

                body_literals = cl.get_atoms()
                head_types = [x.get_type() for x in cl.get_head().get_terms()] + [high_order_var.get_type()]

                # abstract each literal
                for lit in body_literals:
                    new_head_pred = c_pred(self._get_new_name(), len(cl.get_head().get_terms()) + 1, head_types)
                    high_lit = Literal(high_order_var, lit.get_terms())
                    new_body_lits = [high_lit if x == lit else x for x in body_literals]

                    cannon = [self._get_cannonical_form(new_body_lits, {high_order_var: 1}, variables=cl.get_head().get_terms()) if x == cl else self._get_cannonical_form(x.get_atoms(), {high_order_var: 1}, variables=x.get_head().get_terms()) for x in clauses]
                    head_vars_c = [x[0] for x in cannon]
                    head_var_signatures = {}
                    for hv_i in range(len(head_vars_c[0])):
                        head_var_signatures[hv_i] = '/'.join([str(x[hv_i]) for x in head_vars_c])
                    head_vars_c = f"({','.join([head_var_signatures[x] for x in head_var_signatures.keys()])})"
                    cannon = [','.join(x[1]) for x in cannon]

                    cannon = head_vars_c + " " + "/".join([str(x) for x in cannon])

                    if cannon in self._candidate_abstractions:
                        # self._candidate_abstractions[cannon]['dependents'].append({'cl': disjunctions[dis_ind], 'bind': {high_order_var: lit.get_predicate()}})
                        self._add_clause_to_candidate_pool(cannon, None, disjunctions[dis_ind],
                                                           {high_order_var: lit.get_predicate()})
                    else:
                        disjunctive_clauses = []

                        for inv_cl in clauses:
                            if inv_cl == cl:
                                new_head_lit = Literal(new_head_pred, inv_cl.get_head().get_terms() + [high_order_var])
                                new_cl = Clause(new_head_lit, new_body_lits)
                                disjunctive_clauses.append(new_cl)
                            else:
                                new_head_lit = Literal(new_head_pred, inv_cl.get_head().get_terms() + [high_order_var])
                                new_cl = Clause(new_head_lit, inv_cl.get_atoms())
                                disjunctive_clauses.append(new_cl)

                        self._add_clause_to_candidate_pool(cannon, Disjunction(disjunctive_clauses), disjunctions[dis_ind],
                                                           {high_order_var: lit.get_predicate()})

            # if a predicate appears  in a definition more than once, also abstract every occurrence of a predicate
            if len(disjunctions[dis_ind].get_predicates()) < sum([len(x) for x in clauses]):
                predicate_appearance_count = {}
                for incl in clauses:
                    for lit in incl.get_atoms():
                        p = lit.get_predicate()
                        if p not in predicate_appearance_count:
                            predicate_appearance_count[p] = 0
                        predicate_appearance_count[p] += 1

                full_definition = disjunctions[dis_ind]
                head_arguments = full_definition.get_head()[0].get_terms() + [high_order_var]
                head_types = [x.get_type() for x in head_arguments]

                predicate_appearance_count = dict([(k, v) for k, v in predicate_appearance_count.items() if v > 1])
                for pred in predicate_appearance_count.keys():
                    cannon = [self._get_cannonical_form([Literal(high_order_var, y.get_terms()) if y.get_predicate() == pred else y for y in x.get_atoms()], {high_order_var: 1}, variables=x.get_head().get_terms()) for x in clauses]
                    cannon = self._format_final_cannon(cannon)

                    if cannon in self._candidate_abstractions:
                        self._add_clause_to_candidate_pool(cannon, None, full_definition, {high_order_var: pred})
                    else:
                        new_head_pred = c_pred(self._get_new_name(), len(head_arguments), head_types)
                        new_clauses = []
                        for tmp_cl in clauses:
                            new_head_lit = Literal(new_head_pred, tmp_cl.get_head().get_terms() + [high_order_var])
                            new_body = [Literal(high_order_var, x.get_terms()) if x.get_predicate() == pred else x for x in tmp_cl.get_atoms()]
                            new_clauses.append(Clause(new_head_lit, new_body))
                        self._add_clause_to_candidate_pool(cannon, Disjunction(new_clauses), full_definition, {high_order_var: pred})



        # recursions
        for rec_ind in range(len(recursions)):
            clauses = recursions[rec_ind].get_clauses()

            # consider abstracting literals in each clause
            for cl in clauses:
                # transform the individual clause to higher-order versions, make sure that everything else is done with the entire disjunction
                body_literals = cl.get_atoms()
                head_types = [x.get_type() for x in cl.get_head().get_terms()] + [high_order_var.get_type()]

                # abstract each literal
                for lit in body_literals:
                    # if it is the recursive literal, skip; do not abstract it
                    if lit.get_predicate() == cl.get_head().get_predicate():
                        continue

                    high_lit = Literal(high_order_var, lit.get_terms())
                    new_body_lits = [high_lit if x == lit else x for x in body_literals]
                    new_head_pred = c_pred(self._get_new_name(), len(cl.get_head().get_terms()) + 1, head_types)
                    # take care of the recursive preds
                    new_body_lits = [x if x.get_predicate() != cl.get_head().get_predicate() else Literal(new_head_pred, x.get_terms() + [high_order_var]) for x in new_body_lits]

                    cannon = [self._get_cannonical_form(new_body_lits, {high_order_var: 1},
                                                        variables=cl.get_head().get_terms()) if x == cl else self._get_cannonical_form(
                        [x if x.get_predicate() != cl.get_head().get_predicate() else Literal(new_head_pred, x.get_terms() + [high_order_var]) for x in x.get_atoms()], {high_order_var: 1}, variables=x.get_head().get_terms()) for x in clauses]
                    head_vars_c = [x[0] for x in cannon]
                    head_var_signatures = {}
                    for hv_i in range(len(head_vars_c[0])):
                        head_var_signatures[hv_i] = '/'.join([str(x[hv_i]) for x in head_vars_c])
                    head_vars_c = f"({','.join([head_var_signatures[x] for x in head_var_signatures.keys()])})"
                    cannon = [','.join(x[1]) for x in cannon]

                    cannon = head_vars_c + " " + "/".join([str(x) for x in cannon])

                    if cannon in self._candidate_abstractions:
                        # self._candidate_abstractions[cannon]['dependents'].append({'cl': disjunctions[dis_ind], 'bind': {high_order_var: lit.get_predicate()}})
                        self._add_clause_to_candidate_pool(cannon, None, recursions[rec_ind],
                                                           {high_order_var: lit.get_predicate()})
                    else:
                        recursive_clauses = []

                        for inv_cl in clauses:
                            if inv_cl == cl:
                                new_head_lit = Literal(new_head_pred, inv_cl.get_head().get_terms() + [high_order_var])
                                new_cl = Clause(new_head_lit, new_body_lits)
                                recursive_clauses.append(new_cl)
                            else:
                                new_head_lit = Literal(new_head_pred, inv_cl.get_head().get_terms() + [high_order_var])
                                # need to do an extra check for the recursive predicate in the body
                                new_cl_body = [x if x.get_predicate() != cl.get_head().get_predicate() else Literal(new_head_pred, x.get_terms() + [high_order_var]) for x in inv_cl.get_atoms()]
                                new_cl = Clause(new_head_lit, new_cl_body)
                                recursive_clauses.append(new_cl)

                        self._add_clause_to_candidate_pool(cannon, Recursion(recursive_clauses), recursions[rec_ind],
                                                           {high_order_var: lit.get_predicate()})

            # abstract each non-recursive predicate in the recursion
            predicate_appearance_count = {}
            for incl in clauses:
                for lit in incl.get_atoms():
                    p = lit.get_predicate()
                    if p not in predicate_appearance_count:
                        predicate_appearance_count[p] = 0
                    predicate_appearance_count[p] += 1

            full_recursion = recursions[rec_ind]
            head_arguments = full_recursion.get_head()[0].get_terms() + [high_order_var]
            head_pred = full_recursion.get_head()[0].get_predicate()
            head_types = [x.get_type() for x in head_arguments]

            # take every predicate that appears more than once and is not the recursive predicate
            predicate_appearance_count = dict([(k, v) for k, v in predicate_appearance_count.items() if v > 1 and k != head_pred])
            for pred in predicate_appearance_count:
                new_head_pred = c_pred(self._get_new_name(), len(head_arguments), head_types)
                cannon = []
                for tmp_cl in clauses:
                    # abstract predicates in the body
                    new_body = [x for x in tmp_cl.get_atoms()]
                    # abstract predicate
                    new_body = [Literal(high_order_var, x.get_terms()) if x.get_predicate() == pred else x for x in new_body]
                    # rename recursive preds
                    new_body = [Literal(new_head_pred, x.get_terms() + [high_order_var]) if x.get_predicate() == head_pred else x for x in new_body]
                    cannon.append(self._get_cannonical_form(new_body, {high_order_var: 1}, variables=tmp_cl.get_head().get_terms()))

                #cannon = [self._get_cannonical_form(
                #    [Literal(high_order_var, y.get_terms()) if y.get_predicate() == pred else y for y in x.get_atoms()],
                #    x.get_head().get_terms()) for x in clauses]
                cannon = self._format_final_cannon(cannon)

                if cannon in self._candidate_abstractions:
                    self._add_clause_to_candidate_pool(cannon, None, full_recursion, {high_order_var: pred})
                else:
                    recursive_clauses = []

                    for tmp_cl in clauses:
                        new_head_lit = Literal(new_head_pred, tmp_cl.get_head().get_terms() + [high_order_var])
                        # rename recursive predicate
                        new_cl_body = [
                            x if x.get_predicate() != head_pred else Literal(new_head_pred, x.get_terms() + [high_order_var])
                            for x in tmp_cl.get_atoms()
                        ]
                        # abstract the predicate
                        new_cl_body = [Literal(high_order_var, x.get_terms()) if x.get_predicate() == pred else x for x in new_cl_body]
                        recursive_clauses.append(Clause(new_head_lit, new_cl_body))

                    self._add_clause_to_candidate_pool(cannon, Recursion(recursive_clauses), full_recursion, {high_order_var: pred})
    

    def _filter_candidates(self):
        self._candidate_abstractions = dict([(x, self._candidate_abstractions[x]) for x in self._candidate_abstractions if len(self._candidate_abstractions[x]['dependents']) > 1])

    def _candidate_selection_vars(self, model: cp_model.CpModel, abstraction_per_clause):
        var_per_clause = {}
        candidates = list(self._candidate_abstractions.keys())
        equivalent_groups = {}   # group all selection variables that refer to the same abstraction
                                 # this is needed to correctly calculate the cost

        for cand_ind in range(len(candidates)):
            cannonical_rep = candidates[cand_ind]
            abs_clause = self._candidate_abstractions[cannonical_rep]['cand']

            if isinstance(abs_clause, (Disjunction, Recursion)):
                pred_name = abs_clause.get_head()[0].get_predicate().get_name()
            else:
                pred_name = abs_clause.get_head().get_predicate().get_name()

            for clause_struct in self._candidate_abstractions[cannonical_rep]['dependents']:
                cl = clause_struct['cl']
                if isinstance(cl, Clause):
                    cl_name = cl.get_head().get_predicate().get_name()
                else:
                    cl_name = cl.get_head()[0].get_predicate().get_name()

                if cl not in var_per_clause:
                    var_per_clause[cl] = {}

                selection_var = model.NewBoolVar(f"{cl_name}/{pred_name}")

                if abs_clause not in equivalent_groups:
                    equivalent_groups[abs_clause] = []
                equivalent_groups[abs_clause].append(selection_var)

                var_per_clause[cl][self._candidate_abstractions[cannonical_rep]['cand']] = selection_var

        return var_per_clause, equivalent_groups

    def _get_valid_abstractions(self):
        abstracts = {}
        candidates = list(self._candidate_abstractions.keys())
        abstraction_costs = {}

        for cand_ind in range(len(candidates)):
            cand = candidates[cand_ind]
            abstraction_to_use = self._candidate_abstractions[cand]['cand']

            if abstraction_to_use not in abstraction_costs:
                abstraction_costs[abstraction_to_use] = 0

            for clause_struct in self._candidate_abstractions[cand]['dependents']:
                clause = clause_struct['cl']
                if clause not in abstracts:
                    abstracts[clause] = []
                abstracts[clause].append(abstraction_to_use)

                abstraction_costs[abstraction_to_use] += 1

        return abstracts, abstraction_costs

    def _restructure_theory(self, theory: ClausalTheory, selected_abstractions):
        all_abstractions = set()

        for cl in selected_abstractions:
            all_abstractions.add(selected_abstractions[cl])

        all_clauses = [x for x in theory.get_formulas()]
        new_clauses = []
        for cannon in self._candidate_abstractions:
            abstraction = self._candidate_abstractions[cannon]['cand']
            if abstraction in all_abstractions:
                new_clauses.append(abstraction)
                for clause_structure in self._candidate_abstractions[cannon]['dependents']:
                    tmp_clause = clause_structure['cl']

                    if abstraction != selected_abstractions[tmp_clause]:
                        continue

                    if isinstance(abstraction, Clause):
                        head = clause_structure['cl'].get_head()
                        high_order_vars = [v for v in abstraction.get_head().get_terms() if isinstance(v, SecondOrderVariable)]
                        arags = clause_structure['cl'].get_head().get_terms() + [clause_structure['bind'][hv] for hv in high_order_vars]
                        body = Literal(abstraction.get_head().get_predicate(), arags)
                        new_clauses.append(Clause(head, [body]))
                    else:
                        head_index = max([(ind, len(set(lit.get_variables()))) for ind, lit in clause_structure['cl'].get_head().items()], key=lambda x: x[1])[0]
                        head = clause_structure['cl'].get_head()[head_index]
                        high_order_vars = [v for v in abstraction.get_head()[head_index].get_terms() if isinstance(v, SecondOrderVariable)]
                        arags = clause_structure['cl'].get_head()[head_index].get_terms() + [
                            clause_structure['bind'][hv] for hv in high_order_vars]
                        body = Literal(abstraction.get_head()[head_index].get_predicate(), arags)
                        new_clauses.append(Clause(head, [body]))

                    all_clauses = [x for x in all_clauses if x != clause_structure['cl']]

        return ClausalTheory(new_clauses + all_clauses)

    def _solve(self, num_threads=1, max_time_s=-1, penalize_variables=False):
        model = cp_model.CpModel()

        abstractions_per_clause, abstraction_costs = self._get_valid_abstractions()
        candidate_vars, equivalence_groups = self._candidate_selection_vars(model, abstractions_per_clause)

        no_abstraction_var_per_clause = dict(
            [(x, model.NewBoolVar(x.get_head().get_predicate().get_name())) if isinstance(x, Clause) else (x, model.NewBoolVar(x.get_head()[0].get_predicate().get_name())) for x in abstractions_per_clause])

        for cl in abstractions_per_clause:
            # either exactly one of the abstractions per clause need to be selected, or no abstraction
            abstraction_vars = [candidate_vars[cl][x] for x in abstractions_per_clause[cl]]
            model.Add(sum(abstraction_vars + [no_abstraction_var_per_clause[cl]]) == 1)

        callback_candidate_vars = []
        weighted_components = []
        # calculate the length of the theory = sum of lengths of the abstraction
        #       (the restructured clause always has 1 lit in the body, so no need to add that)
        #       calculate only once per equivalence group, otherwise the abstruction length is counter multiple times
        equivalent_var_count = 1
        for group_rep_clause in equivalence_groups:
            tmp_var = model.NewBoolVar(f"equiv_var_{equivalent_var_count}")
            model.AddBoolOr(equivalence_groups[group_rep_clause]).OnlyEnforceIf(tmp_var)
            model.AddBoolAnd([x.Not() for x in equivalence_groups[group_rep_clause]]).OnlyEnforceIf(tmp_var.Not())
            if isinstance(group_rep_clause, Clause):
                clause_size = len(group_rep_clause) + int(penalize_variables)*len(group_rep_clause.get_head().get_terms())
            else:
                clause_size = sum([len(x) for x in group_rep_clause.get_clauses()]) + int(penalize_variables)*len(group_rep_clause.get_head()[0].get_terms()) # <- penalty on the number of introduced vars
            weighted_components += [clause_size*tmp_var]

            equivalent_var_count += 1
            callback_candidate_vars.append(tmp_var)

        # weighted_components = [abstraction_costs[x]*candidate_vars[x] for x in abstraction_costs]
        weighted_components += [sum([len(c) for c in x.get_clauses()])*no_abstraction_var_per_clause[x] if isinstance(x, (Disjunction, Recursion)) else len(x)*no_abstraction_var_per_clause[x] for x in no_abstraction_var_per_clause]

        model.Minimize(reduce(lambda x, y: x + y, weighted_components))

        solver = cp_model.CpSolver()
        solver.parameters.num_search_workers = num_threads
        if max_time_s > 0:
            solver.parameters.max_time_in_seconds = max_time_s


        #solution_callback = VarArraySolutionPrinter([candidate_vars[x] for x in candidate_vars])
        solution_callback = VarArraySolutionPrinter(callback_candidate_vars)
        print(f"{datetime.datetime.now()} Started solving")
        status = solver.SolveWithSolutionCallback(model, solution_callback)  # solver.Solve(model)
        print(f"Solving done; status: {status}")

        # print(f"OPTIMAL: {cp_model.OPTIMAL}\nFEASIBLE: {cp_model.FEASIBLE}\nUNKNOWN: {cp_model.UNKNOWN}")

        if status in (cp_model.OPTIMAL, cp_model.FEASIBLE):
            selected_clauses = {}
            for cl in candidate_vars:
                selected_clauses[cl] = {x for x in candidate_vars[cl] if solver.Value(candidate_vars[cl][x]) == 1}
                # selected_clauses = {x for x in candidate_vars if solver.Value(candidate_vars[x]) == 1}
            return dict([(k, list(v)[0]) for k, v in selected_clauses.items() if len(v) > 0])
        else:
            raise Exception("cannot find satisfiable solution")

    def abstract(self, max_higher_order_vars=1, min_higher_order_vars=1, penalize_variables=False, threads=1, max_time_s=-1):
        self._extract_candidates_new(max_predicate_to_abstract=max_higher_order_vars,
                                     min_predicates_to_abstract=min_higher_order_vars)

        # print(len(self._candidate_abstractions))
        # for k in self._candidate_abstractions:
        #     print(self._candidate_abstractions[k]['cand'])
        # print("\n\n\n\n\n\n")
        # ensures there is at least one dependent definition
        self._filter_candidates()
        #
        # print(len(self._candidate_abstractions))
        # for k in self._candidate_abstractions:
        #     print(self._candidate_abstractions[k]['cand'])


        if len(self._candidate_abstractions) == 0:
            return dict(), self._clauses

        selected_abstractions = self._solve(num_threads=threads, max_time_s=max_time_s, penalize_variables=penalize_variables)

        new_th = self._restructure_theory(self._clauses, selected_abstractions)

        th = [x for x in new_th.get_formulas()]
        new_th = ClausalTheory([alphabeticiseClausalConstruct(c, from_pred_name=False) for c in th])

        return selected_abstractions, new_th


        















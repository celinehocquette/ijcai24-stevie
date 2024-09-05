import datetime
import os
import sys
from itertools import combinations
from functools import reduce

from stevie.loreleai.language.lp import ClausalTheory
from stevie.loreleai.learning.restructuring import Restructor
from stevie.loreleai.language.commons import are_variables_connected, Literal, Predicate, Clause


def remove_redundancies(input_theory_file, output_theory_file):
    theory = ClausalTheory(read_from_file=input_theory_file)

    redundancy_counts = {}

    for cl in theory.get_formulas():
        enc = cl.get_atoms()
        for l in range(2, len(enc) + 1):
            for env_cmb in combinations(enc, l):
                if not are_variables_connected(env_cmb):
                    continue

                #env_cmb = sorted_incr(env_cmb, key=lambda x: x.get_predicate().get_name())

                # order variables
                var_indices = {}
                for atm in env_cmb:
                    for v in atm.get_variables():
                        if v not in var_indices:
                            var_indices[v] = len(var_indices)

                # create informative key (not depending on variable names)
                signature = tuple([
                                f'{x.get_predicate().get_name()}({",".join([str(var_indices[y]) for y in x.get_variables()])})'
                                for x in env_cmb])

                if signature not in redundancy_counts:
                    redundancy_counts[signature] = {}

                if cl not in redundancy_counts[signature]:
                    redundancy_counts[signature][cl] = []

                redundancy_counts[signature][cl].append(env_cmb)

    # filter to redundancies that reoccure
    redundancy_counts = dict([(k, v) for k, v in redundancy_counts.items() if len(v) > 1])

    clauses_representing_redundancy = {}
    redundant_theory = []
    new_clause_construction_index = 1

    clauses_to_change = reduce(lambda x, y: x.union(y), {tuple(v.keys()) for k, v in redundancy_counts.items()}, set())
    clause_to_redundancy_sign = {}
    for red_sig in redundancy_counts:
        for incl in redundancy_counts[red_sig]:
            if incl not in clause_to_redundancy_sign:
                clause_to_redundancy_sign[incl] = set()
            clause_to_redundancy_sign[incl].add(red_sig)

    new_theory = []
    for cl in theory.get_formulas():
        if cl in clauses_to_change:
            # go over all redundancy signatures
            for red_sig in clause_to_redundancy_sign[cl]:
                all_redundancies = redundancy_counts[red_sig][cl]
                new_cl = cl

                for redundancy in all_redundancies:
                    var_appearance = {}
                    for ind, lit in enumerate(redundancy):
                        for v in lit.get_variables():
                            if v not in var_appearance:
                                var_appearance[v] = set()
                            var_appearance[v].add(ind)

                    if len(var_appearance) == len(cl.get_head().get_terms()):
                        var_appearance = cl.get_head().get_terms()
                    else:
                        var_appearance = dict([(k,v) for k, v in var_appearance.items() if len(v) == 1])
                        var_appearance = sorted(list(var_appearance.keys()), key=lambda x: var_appearance[x])

                    if red_sig not in clauses_representing_redundancy:
                        new_head_predicate = Predicate(f"redpred_{new_clause_construction_index}", len(var_appearance))
                        new_clause_construction_index += 1
                        new_head_literal = Literal(new_head_predicate, var_appearance)
                        rcl = Clause(new_head_literal, redundancy)
                        clauses_representing_redundancy[red_sig] = rcl
                        redundant_theory.append(rcl)

                    literal_to_use = clauses_representing_redundancy[red_sig].get_head()
                    new_cl = new_cl.substitute_atoms(redundancy, literal_to_use, dict(zip(literal_to_use.get_terms(), var_appearance)))

                new_theory.append(new_cl)
        else:
            new_theory.append(cl)

    new_theory = redundant_theory + new_theory

    out_th = open(output_theory_file, 'w')
    for cl in new_theory:
        out_th.write(str(cl) + "\n")
    out_th.close()


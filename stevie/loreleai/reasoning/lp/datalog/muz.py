from functools import reduce
from math import log, ceil
from typing import Union, Dict, Sequence

from z3 import (
    Fixedpoint,
    BitVecSort,
    Const,
    BoolSort,
    Function,
    BitVecVal,
    is_and,
    is_or,
    is_false,
)

from loreleai.language.commons import Context
from loreleai.language.lp import (
    Type,
    Constant,
    Variable,
    Predicate,
    Literal,
    Clause,
    c_id_to_const,
)
from loreleai.language.utils import MUZ
from .datalogsolver import DatalogSolver


class MuZ(DatalogSolver):
    """
    Z3's muZ (datalog engine)

    Arguments:
        knowledge_base (default: None): facts to use
                                        Not supported yet
        background_knowledge (default: None): background knowledge (clauses)
                                              Not supported yet
        ctx [Context] (default: global context): context to use
    """

    def __init__(
        self, knowledge_base=None, background_knowledge=None, ctx: Context = None
    ):
        self._solver = Fixedpoint()
        self._solver.set(engine="datalog")
        super().__init__(MUZ, knowledge_base, background_knowledge, ctx)

    def declare_type(self, elem_type: Type):
        s = BitVecSort(ceil(log(len(elem_type), 2)))
        elem_type.add_engine_object(s)

    def declare_constant(self, elem_constant: Constant):
        s = elem_constant.get_type().get_engine_obj(self._name)
        c = BitVecVal(elem_constant.id(), s)
        elem_constant.add_engine_object(c)

    def declare_variable(self, elem_variable: Variable):
        s = elem_variable.get_type().get_engine_obj(self._name)
        v = Const(elem_variable.name, s)
        self._solver.declare_var(v)
        elem_variable.add_engine_object(v)

    def declare_predicate(self, elem_predicate: Predicate):
        arg_types = [
            x.get_engine_obj(self._name) for x in elem_predicate.get_arg_types()
        ]
        arg_types += [BoolSort()]
        rel = Function(elem_predicate.get_name(), *arg_types)
        self._solver.register_relation(rel)
        elem_predicate.add_engine_object(rel)

    def assert_fact(self, fact: Literal):
        self._solver.fact(fact.as_muz())

    def assert_rule(self, rule: Clause):
        cl_muz = rule.as_muz()
        self._solver.rule(cl_muz[0], cl_muz[1])

    def has_solution(self, query: Union[Literal, Clause]) -> bool:
        """
        Checks whether a query has a solution

        Arguments:
            query [Union[Literal, Clause]]: a query to check

        Returns:
            True if there is a solution, False is no

        """
        if isinstance(query, Literal):
            q = query.as_muz()
            res = self._solver.query(q)
            return True if res.r == 1 else False
        elif isinstance(query, Clause):
            body_atms = [x.as_muz() for x in query.get_atoms()]
            res = self._solver.query(*body_atms)
            return True if res.r == 1 else False
        else:
            raise Exception(f"Cannot query {type(query)}")

    def one_solution(self, query: Union[Literal, Clause]) -> Dict[Variable, Constant]:
        """
        Returns one (random) solution to the query

        Arguments:
            query query (Union[Atom,Clause]): query to check

        Return:
            dict (Dict[Variable,Constant]) mapping the variables in the query to constaints
        """
        if isinstance(query, (Literal, Clause)):
            if isinstance(query, Literal):
                self._solver.query(query.as_muz())
            else:
                body_atms = [x.as_muz() for x in query.get_atoms()]
                self._solver.query(*body_atms)

            ans = self._solver.get_answer()

            if is_false(ans):
                # no answer
                return {}
            elif not (is_and(ans) or is_or(ans)):
                # value assignment of a single variable
                val = int(ans.children()[1].as_long())
                varb = query.get_variables()[0]
                return {varb: c_id_to_const(val, varb.get_type())}
            elif is_or(ans) and not (
                is_and(ans.children()[0]) or is_or(ans.children()[0])
            ):
                # multiple value assignments to a single variable
                ans = ans.children()[0]
                val = int(ans.children()[1].as_long())
                varb = query.get_variables()[0]
                return {varb: c_id_to_const(val, varb.get_type())}
            elif is_and(ans):
                # single solution of more than 1 variable
                pass
            elif is_or(ans):
                # multiple solutions to more than 1 variable
                ans = ans.children()[0]
            else:
                raise Exception(f"don't know how to parse {ans}")

            ans = [int(x.children()[1].as_long()) for x in ans.children()]

            if isinstance(query, Literal):
                args = query.get_variables()
            else:
                tmp_args = [v for x in query.get_atoms() for v in x.get_variables()]
                args = reduce(lambda x, y: x + [y] if y not in x else x, tmp_args, [])

            if isinstance(query, Literal):
                return dict(
                    [
                        (v, c_id_to_const(c, v.get_type().name))
                        for v, c in zip(args, ans)
                    ]
                )
            else:
                head_vars = query.get_head().get_variables()
                return dict(
                    [
                        (v, c_id_to_const(c, v.get_type().name))
                        for v, c in zip(args, ans)
                        if v in head_vars
                    ]
                )
        else:
            raise Exception(f"Cannot query {type(query)}")

    def all_solutions(
        self, query: Union[Literal, Clause]
    ) -> Sequence[Dict[Variable, Constant]]:
        """
        Returns all solutions to the query

        Arguments:
            query query (Union[Atom,Clause]): query to check

        Return:
            sequence of dict (Dict[Variable,Constant]) mapping the variables in the query to constants
        """
        if isinstance(query, (Literal, Clause)):
            if isinstance(query, Literal):
                self._solver.query(query.as_muz())
            else:
                body_atms = [x.as_muz() for x in query.get_atoms()]
                self._solver.query(*body_atms)

            ans = self._solver.get_answer()

            if is_false(ans):
                # no solution
                return []
            elif not (is_and(ans) or is_or(ans)):
                # single solution, value of a single variable
                val = int(ans.children()[1].as_long())
                varb = query.get_variables()[0]
                return [{varb: c_id_to_const(val, varb.get_type())}]
            elif is_or(ans) and not (
                is_and(ans.children()[0]) or is_or(ans.children()[0])
            ):
                # multiple solutions of single variable
                vals = [int(x.children()[1].as_long()) for x in ans.children()]
                varbs = query.get_variables()[0]
                varbs = [varbs] * len(vals)
                return [
                    {k: c_id_to_const(v, varbs[0].get_type())}
                    for k, v in zip(varbs, vals)
                ]
            elif is_and(ans):
                # single solution of more than 1 variable
                ans = [int(x.children()[1].as_long()) for x in ans.children()]
                ans = [ans]
            elif is_or(ans):
                # multiple solutions of more than 1 variable
                ans = ans.children()
                ans = [
                    [int(y.children()[1].as_long()) for y in x.children()] for x in ans
                ]
            else:
                raise Exception(f"don't know how to parse {ans}")

            if isinstance(query, Literal):
                args = query.get_variables()
            else:
                tmp_args = [v for x in query.get_atoms() for v in x.get_variables()]
                args = reduce(lambda x, y: x + [y] if y not in x else x, tmp_args, [])

            if isinstance(query, Literal):
                return [
                    dict(
                        [
                            (v, c_id_to_const(c, v.get_type().name))
                            for v, c in zip(args, x)
                        ]
                    )
                    for x in ans
                ]
            else:
                head_vars = query.get_head().get_variables()
                return [
                    dict(
                        [
                            (v, c_id_to_const(c, v.get_type().name))
                            for v, c in zip(args, x)
                            if v in head_vars
                        ]
                    )
                    for x in ans
                ]
        elif isinstance(query, Clause):
            raise NotImplementedError()
        else:
            raise Exception(f"Cannot query {type(query)}")

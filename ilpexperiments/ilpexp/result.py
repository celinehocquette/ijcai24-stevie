import json
import inspect
import re


class ExperimentResult:
    def __init__(self, problem_name, system_name, trial, solution, total_exec_time, conf_matrix, extra_stats, parameter=None):
        self.problem_name = problem_name
        self.system_name = system_name
        self.trial = trial
        self.parameter = parameter
        self.solution = solution
        self.total_exec_time = total_exec_time
        self.extra_stats = extra_stats
        self.conf_matrix = conf_matrix
        clauses = [s for s in solution.split('.') if s] if solution else None
        self.num_clauses = len(clauses) if clauses else None
        self.num_literals = sum([n_literals(c) for c in clauses]) if clauses else None

    def __str__(self):
        return f'{self.problem_name}__{self.system_name} :: {self.total_exec_time:.2f}s :: {self.accuracy} :: ' \
               f'num clauses {self.num_clauses} :: num literals {self.num_literals}\n {self.solution}'

    def hash(self):
        return hash(f'{self.problem_name}'+f'{self.system_name}'+f'{self.trial}')

    @property
    def accuracy(self):
        if self.conf_matrix:
            tp, fn, tn, fp = self.conf_matrix
            return (tp + tn) / (tp+fn+tn+fp)
        return .5

TYPE = '__typ__'
WRITABLE_CLASSES = {ExperimentResult}
NAME_TO_CLASS = {clz.__name__:clz for clz in WRITABLE_CLASSES}

class ResultEncoder(json.JSONEncoder):
    def default(self, obj):
        if obj.__class__ in WRITABLE_CLASSES:
            init_vars = inspect.getfullargspec(obj.__init__)[0]
            all_vars = vars(obj)
            final_dict = {key:all_vars[key] for key in init_vars if key in all_vars}
            final_dict[TYPE] = obj.__class__.__name__
            return final_dict
        else:
            return super().default(obj)

def write_result(file, out):
    with open(file, "w") as f:
        f.write(json.dumps(out, cls=ResultEncoder))    

def decode_result(dct):
    if TYPE in dct:
        clazz = NAME_TO_CLASS[dct[TYPE]]
        init_vars = inspect.getfullargspec(clazz.__init__)[0]
        final_dict = {key:dct[key] for key in init_vars if key in dct}
        return clazz(**final_dict)
    return dct


def n_literals(clause):
    head, body = process_clause(clause)
    n_lit_h = len(head)
    n_lit_b = len(body)
    assert n_lit_h < 2
    return n_lit_h + n_lit_b

def process_clause(clause):
    [head, body] = clause.split(':-')
    body = split_lit(body)
    return [head], body

def split_lit(str):
    return re.findall('[a-z0-9_-]*\([a-zA-Z0-9,]*\)', str)

def process_literal(lit):
    lit_pred = lit.split("(")[0]
    lit_args = lit.split("(")[1].split(")")[0].split(",")
    return lit_pred, len(lit_args), lit_args
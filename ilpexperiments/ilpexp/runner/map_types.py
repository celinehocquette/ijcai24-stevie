
from ..problem.ascii_art import AsciiProblem
from ..problem.chess import ChessProblem
from ..problem.list import ListProblem
from ..problem.listHigherOrder import ListProblem as ListHoProblem
from ..problem.strings import StringProblem
from ..problem.waiter import WaiterProblem
from ..problem.waiter2 import WaiterProblem2


synthesis_to_waiter = {'list': 'state', 'element': 'position', 'int': 'state'}
synthesis_to_chess = {'list': 'state', 'element': 'element', 'int': 'element'}
synthesis_to_ascii = {'list': 'state', 'element': 'position', 'int': 'position'}
synthesis_to_string = {'list': 'string', 'element': 'letter', 'int': 'letter'}
synthesis_to_listho = {'list': 'list', 'element': 'element', 'int': 'int'}
synthesis_to_list = {'list': 'list', 'element': 'element', 'int': 'int'}
synthesis_to_tree = {'list': 'list', 'element': 'element', 'int': 'int'}

def map_types(problem, types):
    if isinstance(problem, StringProblem):
        domain = 'string'
    elif isinstance(problem, ListProblem):
        domain = 'list'
    elif isinstance(problem, ChessProblem):
        domain = 'chess'
    elif isinstance(problem, WaiterProblem) or isinstance(problem, WaiterProblem2):
        domain = 'waiter'
    elif isinstance(problem, ListHoProblem):
        if problem.name == 'isSubTree' or problem.name == 'isBranch' or problem.name == 'depth':
            domain = 'tree'
        else:
            domain = 'listho'
    elif isinstance(problem, AsciiProblem):
        domain = 'ascii'
    else:
        raise 'Domain not recognised'
    new_types = {ho_func: tuple([my_map(f"synthesis_to_{domain}", t) for t in ho_types]) for ho_func, ho_types in types.items()}
    return new_types


def my_map(mydict, input):
    if not isinstance(input, tuple) and input not in globals()[mydict]:
        return input
    elif isinstance(input, tuple):
        return tuple([globals()[mydict][a] if a != "" else "" for a in input])
    return globals()[mydict][input]
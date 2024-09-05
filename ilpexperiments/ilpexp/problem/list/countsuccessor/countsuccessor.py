import random
from ..list import ListProblem, gen_list
from functools import partial


def gen_pos(taskname, k):
    while True:
        if taskname == 'one' or  taskname == 'zero':
            x = gen_list(min_element=0, max_element=1)
        else:
            x = gen_list(min_element=-5, max_element=5)
        z = len([a for a in x if eval(taskname+f'({a})')])+k
        if z < 3:
            continue
        return f'countsuccessor_{taskname}_{k}({x},{z})'


def gen_neg(taskname, k):
    while True:
        if taskname == 'one' or  taskname == 'zero':
            x = gen_list(min_element=0, max_element=1)
        else:
            x = gen_list(min_element=-5, max_element=5)
        z = len([a for a in x if eval(taskname + f'({a})')])+k
        if z < len(x)//3:
            continue
        y = random.randint(0, len(x))
        if y != z:
            return f'countsuccessor_{taskname}_{k}({x},{y})'


def one(x):
    return x == 1


def zero(x):
    return x == 0


def odd(x):
    return x % 2 == 1


def even(x):
    return x % 2 == 0


def negative(x):
    return x < 0


def positive(x):
    return x >= 0


def evenpositive(x):
    return x >= 0 and x % 2 == 0

def oddpositive(x):
    return x >= 0 and x % 2 == 1


class CountSuccessor(ListProblem):
    def __init__(self, taskname, k):
        self.taskname = f"countsuccessor_{taskname}_{k}"
        gen_pos_partial = partial(gen_pos, taskname, k)
        gen_neg_partial = partial(gen_neg, taskname, k)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname, num_examples=[50, 50, 1000, 1000])

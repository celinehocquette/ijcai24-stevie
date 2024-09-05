import random
from ..list import ListProblem, gen_list, MAX_ELEMENT
from functools import partial


def gen_pos(taskname):
    while True:
        if taskname == 'zero' or taskname == 'one':
            x = gen_list(min_element=0, max_element=1)
        elif taskname == 'minusone':
            x = gen_list(min_element=-1, max_element=1)
        else:
            x = gen_list(min_element=-5, max_element=5)
        z = [a for a in x if eval(taskname+f'({a})')]
        if len(z) < 2:
            continue
        y = [a for a in x if not eval(taskname+f'({a})')]
        return f'filter_{taskname}({x},{y})'


def gen_neg(taskname):
    while True:
        if taskname == 'zero' or taskname == 'one':
            x = gen_list(min_element=0, max_element=1)
        elif taskname == 'minusone':
            x = gen_list(min_element=-1, max_element=1)
        else:
            x = gen_list(min_element=-5, max_element=5)
        ignored = random.sample([i for i in range(len(x))], random.randint(1, len(x)))
        y = [a for i, a in enumerate(x) if i not in ignored]
        z = [a for a in x if not eval(taskname+f'({a})')]
        if y != z:
            return f'filter_{taskname}({x},{y})'


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


class Filter(ListProblem):
    def __init__(self, taskname):
        self.taskname = f"filter_{taskname}"
        gen_pos_partial = partial(gen_pos, taskname)
        gen_neg_partial = partial(gen_neg, taskname)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname, num_examples=[60, 60, 1000, 1000])

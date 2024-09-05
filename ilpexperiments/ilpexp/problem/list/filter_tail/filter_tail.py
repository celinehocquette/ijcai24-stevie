import random
from ..list import ListProblem, gen_list, MAX_ELEMENT
from functools import partial


def gen_pos(taskname, k):
    while True:
        if 'one' in taskname or 'zero' in taskname:
            x = gen_list(min_element=0, max_element=1)
        else:
            x = gen_list(min_element=-5, max_element=5)
        z = [a for a in x if eval(taskname+f'({a})')]
        y = [a for a in x if not eval(taskname+f'({a})')]
        if len(z) < 2 or len(y) < k:
            continue
        return f'filter_{taskname}_tail_{k}({x},{y[k:]})'


def gen_neg(taskname, k):
    while True:
        if 'one' in taskname or 'zero' in taskname:
            x = gen_list(min_element=0, max_element=1)
        else:
            x = gen_list(min_element=-5, max_element=5)
        z = [a for a in x if eval(taskname+f'({a})')]
        v = [a for a in x if not eval(taskname+f'({a})')]
        if len(z) < 2 or len(v) < k:
            continue
        u = random.random()
        if u > 0.5:
            ignored = random.sample([i for i in range(len(x))], min(3, len(x)))
            y = [a for i, a in enumerate(x) if i not in ignored]
            u = [a for a in y if not eval(taskname+f'({a})')]
            if v[k:] == u[k:]:
                continue
            return f'filter_{taskname}_tail_{k}({x},{u[k:]})'
        else:
            k1 = random.choice([i for i in range(len(v)) if i != k])
            if v[k:] == v[k1:]:
                continue
            return f'filter_{taskname}_tail_{k}({x},{v[k1:]})'



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


class FilterTail(ListProblem):
    def __init__(self, taskname, k):
        self.taskname = f"filter_{taskname}_tail_{k}"
        gen_pos_partial = partial(gen_pos, taskname, k)
        gen_neg_partial = partial(gen_neg, taskname, k)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname)

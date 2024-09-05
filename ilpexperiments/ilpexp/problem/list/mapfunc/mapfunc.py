import random
from ..list import ListProblem, gen_list, MAX_ELEMENT
from functools import partial


def gen_pos(func1, func2):
    while True:
        x = gen_list(min_len=2, min_element=0, max_element=MAX_ELEMENT)
        z = list(map(eval(func1), x))
        y = eval(func2+f'({z})')
        return f'mapfunc_{func1}_{func2}({x},{y})'


def gen_neg(func1, func2):
    x = gen_list(min_len=2, min_element=0, max_element=MAX_ELEMENT)
    z = list(map(eval(func1), x))
    y = eval(func2 + f'({z})')
    t = y[:]
    while t == y:
        n_mutations = random.randint(0, len(t))
        for _ in range(n_mutations):
            i = random.randint(0, len(t)-1)
            t[i] = random.randint(0, MAX_ELEMENT)
    return f'mapfunc_{func1}_{func2}({x},{t})'


def changesign(x):
    return -x


def increment(x):
    return x+1


def double(x):
    return 2*x


def triple(x):
    return 2*x


def square(x):
    return x*x


def bin(a):
    return list(map(int,list(format(a, "b"))))


def addlast1(a):
    a[-1] += 1
    return a


def addhead1(a):
    a[0] += 1
    return a


def tail(a):
    return a[1:]


def duplhead(a):
    return [a[0]]+a


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


class MapFunc(ListProblem):
    def __init__(self, func1, func2):
        self.taskname = f"mapfunc_{func1}_{func2}"
        gen_pos_partial = partial(gen_pos, func1, func2)
        gen_neg_partial = partial(gen_neg, func1, func2)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname, num_examples=[60, 60, 1000, 1000])

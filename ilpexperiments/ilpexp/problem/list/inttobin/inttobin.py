import random
import string

from ..list import gen_list, ListProblem, MAX_ELEMENT


def gen_pos():
    x = gen_list()
    y = list([list(map(int, list(format(a, "b")))) for a in x])
    return f'inttobin({x},{y})'


def gen_neg():
    x = gen_list()
    y = list([list(map(int, list(format(a, "b")))) for a in x])
    while y == list([list(map(int, list(format(a, "b")))) for a in x]):
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out = []
        for i, a in enumerate(y):
            if i in changes:
                u = random.random()
                if u < 0.9:
                    out.append(x[i])
                else:
                    out.append(random.randint(0, MAX_ELEMENT))
            else:
                out.append(a)
        y = out
    return f'inttobin({x},{y})'


INTTOBIN = 'inttobin'


class IntToBin(ListProblem):
    def __init__(self):
        super().__init__(INTTOBIN, gen_pos, gen_neg, INTTOBIN, num_examples=[60, 60, 1000, 1000])


import random
import string

from ..list import ListProblem, MAX_LIST_SIZE


def gen_pos():
    x, y = gen_pos_pair()
    return f'chartobin({x},{y})'


def gen_pos_pair():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    x = [random.choice(string.ascii_lowercase) for _ in range(n)]
    y = list([ord(a) for a in x])
    z = list([list(map(int, list(format(a, "b")))) for a in y])
    return x, z


def gen_neg():
    x, y = gen_pos_pair()
    o = y[:]
    elements = [ord(c) for c in string.ascii_lowercase]
    while o == y:
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out = []
        for i, a in enumerate(y):
            if i in changes:
                out.append(random.choice(list([list(map(int, list(format(a, "b")))) for a in elements])))
            else:
                out.append(a)
        y = out
    return f'chartobin({x},{y})'


CHARTOBIN = 'chartobin'


class CharToBin(ListProblem):
    def __init__(self):
        super().__init__(CHARTOBIN, gen_pos, gen_neg, CHARTOBIN, num_examples=[60, 60, 1000, 1000])

import random
import string

from ..list import ListProblem, MAX_LIST_SIZE


def gen_pos():
    x, y = gen_pos_pair()
    return f'chartointsorteddecr({x})'


def gen_pos_pair():
    n = random.randint(2, MAX_LIST_SIZE + 1)
    x = sorted([random.choice(string.ascii_lowercase) for _ in range(n)], reverse=True)
    y = list([ord(a) for a in x])
    return x, y


def gen_neg():
    while True:
        x, y = gen_pos_pair()
        z = x[:]
        num_mutations = random.randint(1, len(x))
        changes = [random.sample(range(len(x)), k=2) for _ in range(num_mutations)]
        for i, j in changes:
            z[i], z[j] = z[j], z[i]
        if z != x:
            return f'chartointsorteddecr({z})'


CHARTOINTSORTEDDECR = 'chartointsorteddecr'


class CharToIntSortedDecr(ListProblem):
    def __init__(self):
        super().__init__(CHARTOINTSORTEDDECR, gen_pos, gen_neg, CHARTOINTSORTEDDECR)


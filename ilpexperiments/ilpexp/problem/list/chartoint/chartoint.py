import random
import string

from ..list import ListProblem, MAX_LIST_SIZE, MAX_ELEMENT


def gen_pos():
    x, y = gen_pos_pair()
    return f'chartoint({x},{y})'


def gen_pos_pair():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    x = [random.choice(string.ascii_lowercase) for _ in range(n)]
    y = list([ord(a) for a in x])
    return x, y


def gen_neg():
    x, y = gen_pos_pair()
    while y == list([ord(a) for a in x]):
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out = []
        for i, a in enumerate(y):
            if i in changes:
                u = random.random()
                if u < 0.8:
                    out.append(x[i])
                else:
                    out.append(random.randint(0, MAX_ELEMENT))
            else:
                out.append(a)
        y = out
    return f'chartoint({x},{y})'


CHARTOINT = 'chartoint'


class CharToInt(ListProblem):
    def __init__(self):
        super().__init__(CHARTOINT, gen_pos, gen_neg, CHARTOINT, num_examples=[60, 60, 1000, 1000])


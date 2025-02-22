import random
import string
from functools import partial

from ..list import ListProblem, MAX_LIST_SIZE


def gen_pos(k):
    x, y = gen_pos_pair(k)
    return f'encrypt_2_{k}({x},{y})'


def gen_pos_pair(k):
    n = random.randint(1, MAX_LIST_SIZE + 1)
    letters = [c for c in string.ascii_lowercase if ord(c) <= ord('z')-k]
    x = [random.choice(letters) for _ in range(n)]
    y = [ord(a)+k for a in x]
    z = list([list(map(int, list(format(a, "b")))) for a in y])
    return x, z


def gen_neg(k):
    x, y = gen_pos_pair(k)
    o = y[:]
    elements = [ord(c) for c in string.ascii_lowercase]
    while y == o:
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out = []
        for i, a in enumerate(y):
            if i in changes:
                out.append(random.choice(list([list(map(int, list(format(a, "b")))) for a in elements])))
            else:
                out.append(a)
        y = out
    return f'encrypt_2_{k}({x},{y})'


class Encrypt2(ListProblem):
    def __init__(self, k):
        self.taskname = f"encrypt_2_{k}"
        gen_pos_partial = partial(gen_pos, k)
        gen_neg_partial = partial(gen_neg, k)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname)

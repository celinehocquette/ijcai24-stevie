import random
import string
from functools import partial

from ..list import ListProblem, MAX_LIST_SIZE


def gen_pos(k):
    x, y = gen_pos_pair(k)
    return f'encrypt_1_{k}({x},{y})'


def gen_pos_pair(k):
    n = random.randint(1, MAX_LIST_SIZE + 1)
    letters = [c for c in string.ascii_lowercase if ord(c) <= ord('z')-k]
    x = [random.choice(letters) for _ in range(n)]
    y = [chr(ord(a)+k) for a in x]
    return x, y


def gen_neg(k):
    x, y = gen_pos_pair(k)
    while y == list([chr(ord(a)+k) for a in x]):
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out = []
        for i, a in enumerate(y):
            if i in changes:
                out.append(random.choice(string.ascii_lowercase))
            else:
                out.append(a)
        y = out
    return f'encrypt_1_{k}({x},{y})'


class Encrypt(ListProblem):
    def __init__(self, k):
        self.taskname = f"encrypt_1_{k}"
        gen_pos_partial = partial(gen_pos, k)
        gen_neg_partial = partial(gen_neg, k)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname)

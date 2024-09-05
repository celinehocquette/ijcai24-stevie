import random

from ..list import ListProblem, gen_list


def gen_pos():
    x = gen_list(min_len=2)
    k = random.randint(1, len(x) - 1)
    y = x[:len(x) - k]
    return f'droplastk({k},{x},{y})'


def gen_neg():
    x = gen_list(min_len=2)
    k = random.randint(1, len(x) - 1)
    return f'droplastk({k},{x},{x})'


DROP_LAST_K = 'droplastk'


class DropLastK(ListProblem):
    def __init__(self):
        super().__init__(DROP_LAST_K, gen_pos, gen_neg, DROP_LAST_K)


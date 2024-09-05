import random
from ..list import ListProblem, gen_list


def gen_pos():
    x = gen_list(min_len=2)
    y = random.randint(1, len(x))
    z = x[y:]
    return f'iteratedropk({y},{x},{z})'


def gen_neg():
    x = gen_list(min_len=2)
    y = random.randint(1, len(x))
    k = random.choice([i for i in range(0, len(x)) if i != y])
    z = x[k:]
    return f'iteratedropk({y},{x},{z})'


DROPK = 'iteratedropk'


class DropK(ListProblem):
    def __init__(self):
        super().__init__(DROPK, gen_pos, gen_neg, DROPK)

    
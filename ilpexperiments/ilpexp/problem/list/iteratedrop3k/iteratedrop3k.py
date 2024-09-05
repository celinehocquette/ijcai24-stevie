import random
from ..list import ListProblem, MAX_ELEMENT, gen_list
import math


def gen_pos():
    x = gen_list(min_len=4)
    y = random.randint(1, math.floor(len(x)//3))
    z = x[3*y:]
    return f'iteratedrop3k({y},{x},{z})'


def gen_neg():
    x = gen_list(min_len=4)
    y = random.randint(1, math.floor(len(x)//3))
    k = random.choice([i for i in range(0, len(x)) if i != 3*y])
    z = x[k:]
    return f'iteratedrop3k({y},{x},{z})'


ITERATEDROP3K = 'iteratedrop3k'


class IterateDrop3K(ListProblem):
    def __init__(self):
        super().__init__(ITERATEDROP3K, gen_pos, gen_neg, ITERATEDROP3K)

    
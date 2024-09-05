import random
from ..list import ListProblem, MAX_ELEMENT, gen_list
import math


def gen_pos():
    x = gen_list(min_len=5)
    y = random.randint(1, math.floor(len(x)//4))
    z = x[4*y:]
    return f'iteratedrop4k({y},{x},{z})'


def gen_neg():
    x = gen_list(min_len=5)
    y = random.randint(1, math.floor(len(x)//4))
    k = random.choice([i for i in range(0, len(x)) if i != 4*y])
    z = x[k:]
    return f'iteratedrop4k({y},{x},{z})'


ITERATEDROP4K = 'iteratedrop4k'


class IterateDrop4K(ListProblem):
    def __init__(self):
        super().__init__(ITERATEDROP4K, gen_pos, gen_neg, ITERATEDROP4K)

    
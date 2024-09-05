import random
from ..list import ListProblem, MAX_ELEMENT, gen_list
import math


def gen_pos():
    x = gen_list(min_len=3)
    y = random.randint(1, math.floor(len(x)//2))
    z = x[2*y:]
    return f'iteratedrop2k({y},{x},{z})'


def gen_neg():
    x = gen_list(min_len=3)
    y = random.randint(1, math.floor(len(x)//2))
    k = random.choice([i for i in range(0, len(x)) if i != 2*y])
    z = x[k:]
    return f'iteratedrop2k({y},{x},{z})'


ITERATEDROP2K = 'iteratedrop2k'


class IterateDrop2K(ListProblem):
    def __init__(self):
        super().__init__(ITERATEDROP2K, gen_pos, gen_neg, ITERATEDROP2K)

    
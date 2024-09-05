import random
from functools import reduce
import numpy

from ..list import ListProblem, gen_list
import math

def gen_pos():
    n = random.randint(1, 10)
    x = [numpy.random.choice([0, 1], p=[0.1, 0.9]) for _ in range(n)]
    y = reduce(lambda a, b: a and b, x)
    return f'andlist({x},{y})'

def gen_neg():
    n = random.randint(1, 10)
    x = [numpy.random.choice([0, 1], p=[0.3, 0.7]) for _ in range(n)]
    y = reduce(lambda a, b: a and b, x)
    z = 0 if y == 1 else 1
    return f'andlist({x},{z})'

ANDLIST = 'andlist'

class AndList(ListProblem):
    def __init__(self):
        super().__init__(ANDLIST, gen_pos, gen_neg, ANDLIST)

    
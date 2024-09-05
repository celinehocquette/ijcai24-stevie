import random
from functools import reduce
import numpy

from ..list import ListProblem, gen_list
import math

def gen_pos():
    n = random.randint(1, 10)
    x = [numpy.random.choice([0, 1], p=[0.7, 0.3]) for _ in range(n)]
    y = reduce(lambda a, b: a or b, x)
    return f'orlist({x},{y})'

def gen_neg():
    n = random.randint(1, 10)
    x = [numpy.random.choice([0, 1], p=[0.9, 0.1]) for _ in range(n)]
    y = reduce(lambda a, b: a or b, x)
    z = 0 if y == 1 else 1
    return f'orlist({x},{z})'

ORLIST = 'orlist'

class OrList(ListProblem):
    def __init__(self):
        super().__init__(ORLIST, gen_pos, gen_neg, ORLIST)

    
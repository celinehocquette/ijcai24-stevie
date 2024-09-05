import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=1)
    y = max(x)
    return f'maxlist({x},{y})'

def gen_neg():
    x = gen_list(min_len=1)
    y = random.choice(x)
    while y == max(x):
        x = gen_list(min_len=1)
        z = random.random()
        if z < 0.5:
            y = random.choice(x)
        else:
            y = x[0]
    return f'maxlist({x},{y})'

MAXLIST = 'maxlist'

class MaxList(ListProblem):
    def __init__(self):
        super().__init__(MAXLIST, gen_pos, gen_neg, MAXLIST, num_examples=[100, 100, 1000, 1000])

    
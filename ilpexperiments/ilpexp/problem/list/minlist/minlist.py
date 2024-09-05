import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=1)
    y = min(x)
    return f'minlist({x},{y})'

def gen_neg():
    x = gen_list(min_len=1)
    y = random.choice(x)
    while y == min(x):
        x = gen_list(min_len=1)
        z = random.random()
        if z < 0.5:
            y = random.choice(x)
        else:
            y = x[0]
    return f'minlist({x},{y})'

MINLIST = 'minlist'

class MinList(ListProblem):
    def __init__(self):
        super().__init__(MINLIST, gen_pos, gen_neg, MINLIST, num_examples=[100, 100, 1000, 1000])

    
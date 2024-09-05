import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=1, min_element=2)
    y = min(x)-1
    return f'minlistminus1({x},{y})'

def gen_neg():
    x = gen_list(min_len=1, min_element=2)
    y = random.choice(x)
    while y == min(x)-1:
        x = gen_list(min_len=1, min_element=2)
        y = random.choice(x)
    return f'minlistminus1({x},{y})'

MINLISTMINUS1 = 'minlistminus1'

class MinListMinus1(ListProblem):
    def __init__(self):
        super().__init__(MINLISTMINUS1, gen_pos, gen_neg, MINLISTMINUS1, num_examples=[100, 100, 1000, 1000])

    
import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=1, min_element=3)
    y = min(x)-2
    return f'minlistminus2({x},{y})'

def gen_neg():
    x = gen_list(min_len=1, min_element=3)
    y = random.choice(x)
    while y == min(x)-2:
        x = gen_list(min_len=1, min_element=3)
        y = random.choice(x)
    return f'minlistminus2({x},{y})'

MINLISTMINUS2 = 'minlistminus2'

class MinListMinus2(ListProblem):
    def __init__(self):
        super().__init__(MINLISTMINUS2, gen_pos, gen_neg, MINLISTMINUS2, num_examples=[100, 100, 1000, 1000])

    
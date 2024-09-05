import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=1, min_element=4)
    y = min(x)-3
    return f'minlistminus3({x},{y})'

def gen_neg():
    x = gen_list(min_len=1, min_element=4)
    y = random.choice(x)
    while y == min(x)-3:
        x = gen_list(min_len=1, min_element=4)
        y = random.choice(x)
    return f'minlistminus3({x},{y})'

MINLISTMINUS3 = 'minlistminus3'

class MinListMinus3(ListProblem):
    def __init__(self):
        super().__init__(MINLISTMINUS3, gen_pos, gen_neg, MINLISTMINUS3, num_examples=[100, 100, 1000, 1000])

    
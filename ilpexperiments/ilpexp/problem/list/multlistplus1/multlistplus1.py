import random
import numpy as np
from ..list import ListProblem, gen_list

MAX_EL = 10
MAX_LEN = 10

def gen_pos():
    x = gen_list(max_len=MAX_LEN, max_element=MAX_EL)
    y = np.prod(x)+1
    return f'multlistplus1({x},{y})'

def gen_neg():
    while True:
        x = gen_list(max_len=MAX_LEN, max_element=MAX_EL)
        z = random.random()
        if z < 0.5:
            y = random.choice(x)
        else:
            y = x[0]
        if y != np.prod(x)+1:
            return f'multlistplus1({x},{y})'

MULT_LIST_PLUS1 = 'multlistplus1'

class MultListPlus1(ListProblem):
    def __init__(self):
        super().__init__(MULT_LIST_PLUS1, gen_pos, gen_neg, MULT_LIST_PLUS1)

    
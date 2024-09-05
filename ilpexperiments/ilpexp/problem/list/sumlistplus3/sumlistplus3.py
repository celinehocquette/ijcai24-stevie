import random
from ..list import ListProblem, gen_list

def gen_pos():
    x = gen_list()
    y = sum(x)+3
    return f'sum_listplus3({x},{y})'

def gen_neg():
    while True:
        x = gen_list()
        y = random.sample(x, 1)
        z = sum(x)+3
        if y != z:
            return f'sum_listplus3({x},{y})'

SUM_LIST_PLUS3 = 'sumlistplus3'

class SumListPlus3(ListProblem):
    def __init__(self):
        super().__init__(SUM_LIST_PLUS3, gen_pos, gen_neg, SUM_LIST_PLUS3)

    
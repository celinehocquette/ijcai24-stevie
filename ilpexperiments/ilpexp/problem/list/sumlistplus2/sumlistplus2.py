import random
from ..list import ListProblem, gen_list

def gen_pos():
    x = gen_list()
    y = sum(x)+2
    return f'sum_listplus2({x},{y})'

def gen_neg():
    while True:
        x = gen_list()
        y = random.sample(x, 1)
        z = sum(x)+2
        if y != z:
            return f'sum_listplus2({x},{y})'

SUM_LIST_PLUS2 = 'sumlistplus2'

class SumListPlus2(ListProblem):
    def __init__(self):
        super().__init__(SUM_LIST_PLUS2, gen_pos, gen_neg, SUM_LIST_PLUS2)

    
import random
from ..list import ListProblem, gen_list

def gen_pos():
    x = sorted(gen_list(min_len=2), reverse=True)
    return f'sorted_decr({x})'

def gen_neg():
    while True:
        x = gen_list(min_len=2)
        y = sorted(x, reverse=True)
        random.shuffle(x)
        if y != x:
            return f'sorted_decr({x})'

SORTED_DECR = 'sorted_decr'

class SortedDecr(ListProblem):
    def __init__(self):
        super().__init__(SORTED_DECR, gen_pos, gen_neg, SORTED_DECR)

    
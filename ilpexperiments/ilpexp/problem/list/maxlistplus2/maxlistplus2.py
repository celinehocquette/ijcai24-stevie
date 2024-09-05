import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=1)
    y = max(x)+2
    return f'maxlistplus2({x},{y})'

def gen_neg():
    x = gen_list(min_len=1)
    y = random.choice(x)
    while y == max(x)+2:
        x = gen_list(min_len=1)
        y = random.choice(x)
        k = random.randint(0, 2)
        y += k
    return f'maxlistplus2({x},{y})'

MAXLISTPLUS2 = 'maxlistplus2'

class MaxListPlus2(ListProblem):
    def __init__(self):
        super().__init__(MAXLISTPLUS2, gen_pos, gen_neg, MAXLISTPLUS2, num_examples=[100, 100, 1000, 1000])

    
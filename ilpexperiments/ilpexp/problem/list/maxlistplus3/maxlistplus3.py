import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=1)
    y = max(x)+3
    return f'maxlistplus3({x},{y})'

def gen_neg():
    x = gen_list(min_len=1)
    y = random.choice(x)
    while y == max(x)+3:
        x = gen_list(min_len=1)
        y = random.choice(x)
        k = random.randint(0, 3)
        y += k
    return f'maxlistplus3({x},{y})'

MAXLISTPLUS3 = 'maxlistplus3'

class MaxListPlus3(ListProblem):
    def __init__(self):
        super().__init__(MAXLISTPLUS3, gen_pos, gen_neg, MAXLISTPLUS3, num_examples=[100, 100, 1000, 1000])

    
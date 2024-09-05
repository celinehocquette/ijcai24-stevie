import random
from functools import partial
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_element=-MAX_ELEMENT, max_element=MAX_ELEMENT, min_len=2)
    x[0] = random.randint(-MAX_ELEMENT, -1)
    y = x[:]
    y[0] = 0
    return f'add1until({x},{y})'

def gen_neg():
    x = gen_list(min_element=-MAX_ELEMENT, max_element=MAX_ELEMENT, min_len=2)
    x[0] = random.randint(-MAX_ELEMENT, -1)
    y = x[:]
    y[0] = random.randint(-MAX_ELEMENT, MAX_ELEMENT)
    while y[0] == 0:
        y[0] = random.randint(-MAX_ELEMENT, MAX_ELEMENT)
    return f'add1until({x},{y})'

def positive(x):
    return x >= 0

def negative(x):
    return x < 0

def even(x):
    return x % 2 == 0

def odd(x):
    return x % 2 == 1

def zero(x):
    return x == 0

def one(x):
    return x == 1

def two(x):
    return x == 2

def three(x):
    return x == 3

def four(x):
    return x == 4

def five(x):
    return x == 5

def six(x):
    return x == 6

class Add1Until(ListProblem):
    def __init__(self):
        super().__init__('add1until', gen_pos, gen_neg, 'add1until')

    
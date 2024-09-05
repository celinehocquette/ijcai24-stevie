import random
from functools import partial
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos(cond):
    while True:
        x = gen_list(min_element=-MAX_ELEMENT, max_element=MAX_ELEMENT, min_len=2)
        for i, a in enumerate(x):
            if eval(cond+f'({a})'):
                x[i] = random.choice([u for u in range(MAX_ELEMENT) if not eval(cond+f'({u})')])
        k = random.randint(1, len(x) - 1)
        x[k] = random.choice([u for u in range(MAX_ELEMENT) if eval(cond+f'({u})')])
        if not eval(cond+f'({x[-1]})'):
            return f'rotateuntil{cond}({x},{x[k:]+x[:k]})'

def gen_neg(cond):
    while True:
        x = gen_list(min_element=-MAX_ELEMENT, max_element=MAX_ELEMENT, min_len=2)
        for i, a in enumerate(x):
            if eval(cond+f'({a})'):
                x[i] = random.choice([u for u in range(MAX_ELEMENT) if not eval(cond+f'({u})')])
        k = random.randint(1, len(x) - 1)
        x[k] = random.choice([u for u in range(MAX_ELEMENT) if eval(cond+f'({u})')])
        i = 0
        while i < len(x) and not eval(cond+f'({x[i]})'):
            i += 1
        if not [j for j in range(len(x)) if not eval(cond+f'({x[j]})')]:
            continue
        k = random.choice([j for j in range(len(x)) if not eval(cond+f'({x[j]})')])
        return f'rotateuntil{cond}({x},{x[k:]+x[:k]})'

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

class RotateUntil(ListProblem):
    def __init__(self, cond):
        gen_pos_func = partial(gen_pos, cond)
        gen_neg_func = partial(gen_neg, cond)
        super().__init__(f'rotateuntil{cond}', gen_pos_func, gen_neg_func, f'rotateuntil{cond}', num_examples=[60, 60, 1000, 1000])

    
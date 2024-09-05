import random

from ..list import ListProblem, gen_list, MAX_LIST_SIZE

def gen_pos():
    k = random.randint(1, 20)
    x = [gen_list(min_len=2) for _ in range(k)]
    y = [droplast(a) for a in x]
    return f'droplast({x},{y})'

def gen_neg():
    k = random.randint(1, MAX_LIST_SIZE)
    x = [gen_list(min_len=2) for _ in range(k)]
    j = random.randint(0, k-1)
    y = [droplast(a) if i != j else a for i, a in enumerate(x)]
    return f'droplast({x},{y})'

def droplast(xs):
    return xs[:-1]

DROP_LAST = 'droplast'

class DropLast(ListProblem):
    def __init__(self):
        super().__init__(DROP_LAST, gen_pos, gen_neg, DROP_LAST)

    
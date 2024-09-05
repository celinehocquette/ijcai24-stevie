import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=2, max_len=15)
    x[0] = random.choice([k for k in range(10)])
    for i in range(1, len(x)):
        x[i] = 2*x[i-1]
    return f'sorted_double({x})'


def gen_neg():
    x = gen_list(min_len=2, max_len=15)
    x[0] = random.choice([k for k in range(10)])
    for i in range(1, len(x)):
        x[i] = 2*x[i-1]
    i = random.randint(0, len(x)-1)
    x[i] = random.choice([k for k in range(10) if k != x[i]])
    return f'sorted_double({x})'


SORTED_DOUBLE = 'sorted_double'

class SortedDouble(ListProblem):
    def __init__(self):
        super().__init__(SORTED_DOUBLE, gen_pos, gen_neg, SORTED_DOUBLE)

    
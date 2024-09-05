import random
import string

from ..list import ListProblem, MAX_LIST_SIZE


def gen_pos():
    x, y = gen_pos_pair()
    return f'chartointsum({x},{y})'


def gen_pos_pair():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    x = [random.choice(string.ascii_lowercase) for _ in range(n)]
    y = list([ord(a) for a in x])
    z = sum(y)
    return x, z


def gen_neg():
    x, z = gen_pos_pair()
    k = random.randint(-z, z)
    while k == 0:
        k = random.randint(-z, z)
    z += k
    return f'chartointsum({x},{z})'


CHARTOINTSUM = 'chartointsum'


class CharToIntSum(ListProblem):
    def __init__(self):
        super().__init__(CHARTOINTSUM, gen_pos, gen_neg, CHARTOINTSUM)


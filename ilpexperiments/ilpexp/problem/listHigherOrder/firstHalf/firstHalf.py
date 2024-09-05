import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE, gen_list

def gen_pos():
    n = random.randint(1, MAX_LIST_SIZE+1)
    if n % 2 == 1:
        n += 1
    x = gen_list(min_len=n, max_len=n)
    return f'f({x},{x[:n//2]})'

def gen_neg():
    n = random.randint(1, MAX_LIST_SIZE+1)
    if n % 2 == 1:
        n += 1
    x = gen_list(min_len=n, max_len=n)
    return f'f({x},{x})'

FIRSTHALF = 'firstHalf'

class FirstHalf(ListProblem):
    def __init__(self):
        super().__init__(FIRSTHALF, gen_pos, gen_neg, FIRSTHALF)

    
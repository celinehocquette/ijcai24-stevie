import random
from ..list import ListProblem, MAX_LIST_SIZE, gen_list


def gen_pos():
    n = random.choice([a for a in range(2, MAX_LIST_SIZE) if a % 2 == 0])
    x = gen_list(min_len=n, max_len=n)
    u = len(x)
    return f'f({x},{x[n // 2:]})'


def gen_neg():
    while True:
        n = random.choice([a for a in range(2, MAX_LIST_SIZE) if a % 2 == 0])
        x = gen_list(min_len=n, max_len=n)
        u = random.randint(0, len(x)-1)
        if u != n//2:
            return f'f({x},{x[u:]})'


LASTHALF = 'lastHalf'


class LastHalf(ListProblem):
    def __init__(self):
        super().__init__(LASTHALF, gen_pos, gen_neg, LASTHALF)


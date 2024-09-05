import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE


def gen_pos_list():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    x = [random.choice([a for a in range(MAX_ELEMENT) if a % 2 == 0]) for _ in range(n)]
    i = random.randint(0, len(x)-1)
    x[i] = 0
    return x


def gen_pos():
    x = gen_pos_list()
    return f'allevenmemberzero({x})'


def gen_neg():
    odds = [a for a in range(MAX_ELEMENT) if a % 2 == 1]
    x = gen_pos_list()
    out = x[:]
    n = random.random()
    if n < 0.5:
        for i in range(len(out)):
            if out[i] == 0:
                out[i] = random.choice([c for c in range(0, MAX_ELEMENT) if c != 0 and c % 2 == 0])
    else:
        while all([c % 2 == 0 for c in out]):
            num_mutations = random.randint(1, len(out)//2+1)
            changes = set(random.sample(range(len(out)), k=num_mutations))
            for i in changes:
                out[i] = random.choice(odds)
    return f'allevenmemberzero({out})'


ALLEVENMEMBERZERO = 'allevenmemberzero'


class Allevenmemberzero(ListProblem):
    def __init__(self):
        super().__init__(ALLEVENMEMBERZERO, gen_pos, gen_neg, ALLEVENMEMBERZERO)


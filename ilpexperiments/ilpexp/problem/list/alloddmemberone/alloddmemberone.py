import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE


def gen_pos_list():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    x = [random.choice([a for a in range(MAX_ELEMENT) if a % 2 == 1]) for _ in range(n)]
    i = random.randint(0, len(x)-1)
    x[i] = 1
    return x


def gen_pos():
    x = gen_pos_list()
    return f'alloddmemberone({x})'


def gen_neg():
    evens = [a for a in range(MAX_ELEMENT) if a % 2 == 0]
    x = gen_pos_list()
    out = x[:]
    n = random.random()
    if n < 0.5:
        for i in range(len(out)):
            if out[i] == 1:
                out[i] = random.choice([c for c in range(0, MAX_ELEMENT) if c != 1 and c % 2 == 1])
    else:
        while all([c % 2 == 1 for c in out]):
            num_mutations = random.randint(1, len(out)//2+1)
            changes = set(random.sample(range(len(out)), k=num_mutations))
            for i in changes:
                out[i] = random.choice(evens)
    return f'alloddmemberone({out})'


ALLODDMEMBERONE = 'alloddmemberone'


class Alloddmemberone(ListProblem):
    def __init__(self):
        super().__init__(ALLODDMEMBERONE, gen_pos, gen_neg, ALLODDMEMBERONE)


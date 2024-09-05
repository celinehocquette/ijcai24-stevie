import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE


def gen_pos_list():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    x = [random.choice([c for c in range(MAX_ELEMENT) if c % 2 == 1]) for _ in range(n)]
    return x


def gen_pos():
    x = gen_pos_list()
    return f'allpositiveallodd({x})'


def gen_neg():
    negatives = [c for c in range(-MAX_ELEMENT, 0)]
    evens = [c for c in range(MAX_ELEMENT) if c % 2 == 0]
    x = gen_pos_list()
    out = x[:]
    n = random.random()
    if n < 0.5:
        while all([c % 2 == 1 for c in out]):
            num_mutations = random.randint(1, len(out))
            changes = set(random.sample(range(len(out)), k=num_mutations))
            for i in changes:
                out[i] = random.choice(evens)
    else:
        while all([c >= 0 for c in out]):
            num_mutations = random.randint(1, len(out))
            changes = set(random.sample(range(len(out)), k=num_mutations))
            for i in changes:
                out[i] = random.choice(negatives)

    return f'allpositiveallodd({out})'


ALLPOSITIVEALLODD = 'allpositiveallodd'


class Allpositiveallodd(ListProblem):
    def __init__(self):
        super().__init__(ALLPOSITIVEALLODD, gen_pos, gen_neg, ALLPOSITIVEALLODD)


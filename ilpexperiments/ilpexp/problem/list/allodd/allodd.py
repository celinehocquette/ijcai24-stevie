import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE


def gen_all_odd():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    return [random.choice([a for a in range(MAX_ELEMENT) if a % 2 == 1]) for _ in range(n)]


def gen_pos():
    x = gen_all_odd()
    return f'allodd({x})'


def gen_neg():
    xs = gen_all_odd()
    num_mutations = random.randint(1, min(len(xs), 3))
    changes = set(random.sample(range(len(xs)), k=num_mutations))
    out = []
    for i, x in enumerate(xs):
        if i in changes:
            out.append(random.choice([a for a in range(MAX_ELEMENT) if a % 2 == 0]))
        else:
            out.append(x)
    return f'allodd({out})'


ALLODD = 'allodd'


class Allodd(ListProblem):
    def __init__(self):
        super().__init__(ALLODD, gen_pos, gen_neg, ALLODD, num_examples=[100,100,1000,1000])


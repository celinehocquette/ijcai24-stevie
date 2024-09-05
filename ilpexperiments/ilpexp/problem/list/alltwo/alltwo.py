import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE

def gen_all_twos():
    n = random.randint(1, MAX_LIST_SIZE+1)
    return [2 for _ in range(n)]

def gen_pos():
    x = gen_all_twos()
    return f'alltwo({x})'


def gen_neg():
    not_two = [x for x in range(1, MAX_ELEMENT+1) if x != 2]
    xs = gen_all_twos()
    num_mutations = random.randint(1, min(len(xs), 3))
    changes = set(random.sample(range(len(xs)), k=num_mutations))
    out = []
    for i, x in enumerate(xs):
        if i in changes:
            out.append(random.choice(not_two))
        else:
            out.append(x)
    return f'alltwo({out})'

ALLTWO = 'alltwo'

class Alltwo(ListProblem):
    def __init__(self):
        super().__init__(ALLTWO, gen_pos, gen_neg, ALLTWO, num_examples=[100, 100, 1000, 1000])

    
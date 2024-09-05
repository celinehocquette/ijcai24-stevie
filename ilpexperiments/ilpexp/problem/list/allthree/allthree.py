import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE

def gen_all_threes():
    n = random.randint(1, MAX_LIST_SIZE+1)
    return [3 for _ in range(n)]

def gen_pos():
    x = gen_all_threes()
    return f'allthree({x})'


def gen_neg():
    not_three = [x for x in range(1, MAX_ELEMENT+1) if x != 3]
    xs = gen_all_threes()
    x = random.random()
    if x < 0.5:
        num_mutations = random.randint(1, min(len(xs), 3))
        changes = set(random.sample(range(len(xs)), k=num_mutations))
        out = []
        for i, x in enumerate(xs):
            if i in changes:
                out.append(random.choice(not_three))
            else:
                out.append(x)
    else:
        new = random.choice(not_three)
        out = [new for _ in range(len(xs))]
    return f'allthree({out})'

ALLTHREE = 'allthree'

class Allthree(ListProblem):
    def __init__(self):
        super().__init__(ALLTHREE, gen_pos, gen_neg, ALLTHREE, num_examples=[100, 100, 1000, 1000])

    
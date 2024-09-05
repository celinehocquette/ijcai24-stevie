import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE

def gen_all_sixs():
    n = random.randint(1, MAX_LIST_SIZE+1)
    return [6 for _ in range(n)]

def gen_pos():
    x = gen_all_sixs()
    return f'allsix({x})'


def gen_neg():
    not_six = [x for x in range(1, MAX_ELEMENT+1) if x != 6]
    xs = gen_all_sixs()
    x = random.random()
    if x<0.5:
        num_mutations = random.randint(1, min(len(xs), 3))
        changes = set(random.sample(range(len(xs)), k=num_mutations))
        out = []
        for i, x in enumerate(xs):
            if i in changes:
                out.append(random.choice(not_six))
            else:
                out.append(x)
    else:
        new = random.choice(not_six)
        out = [new for _ in range(len(xs))]
    return f'allsix({out})'

ALLSIX = 'allsix'

class AllSix(ListProblem):
    def __init__(self):
        super().__init__(ALLSIX, gen_pos, gen_neg, ALLSIX, num_examples=[100, 100, 1000, 1000])

    
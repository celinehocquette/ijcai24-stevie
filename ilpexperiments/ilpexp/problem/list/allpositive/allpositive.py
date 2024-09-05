import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE


def gen_all_positive():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    return [random.randint(0, MAX_ELEMENT) for _ in range(n)]


def gen_pos():
    x = gen_all_positive()
    return f'allpositive({x})'


def gen_neg():
    negatives = [x for x in range(-MAX_ELEMENT, 0)]
    xs = gen_all_positive()
    num_mutations = random.randint(1, len(xs))
    changes = set(random.sample(range(len(xs)), k=num_mutations))
    out = []
    for i, x in enumerate(xs):
        if i in changes:
            out.append(random.choice(negatives))
        else:
            out.append(x)
    return f'allpositive({out})'


ALLPOSITIVE = 'allpositive'


class Allpositive(ListProblem):
    def __init__(self):
        super().__init__(ALLPOSITIVE, gen_pos, gen_neg, ALLPOSITIVE, num_examples=[100,100,1000,1000])


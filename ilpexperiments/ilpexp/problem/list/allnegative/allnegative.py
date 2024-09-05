import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE


def gen_all_negative():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    return [random.randint(-MAX_ELEMENT, -1) for _ in range(n)]


def gen_pos():
    x = gen_all_negative()
    return f'allnegative({x})'


def gen_neg():
    positives = [x for x in range(0, MAX_ELEMENT)]
    xs = gen_all_negative()
    num_mutations = random.randint(1, len(xs))
    changes = set(random.sample(range(len(xs)), k=num_mutations))
    out = []
    for i, x in enumerate(xs):
        if i in changes:
            out.append(random.choice(positives))
        else:
            out.append(x)
    return f'allnegative({out})'


ALLNEGATIVE = 'allnegative'


class Allnegative(ListProblem):
    def __init__(self):
        super().__init__(ALLNEGATIVE, gen_pos, gen_neg, ALLNEGATIVE, num_examples=[100,100,1000,1000])


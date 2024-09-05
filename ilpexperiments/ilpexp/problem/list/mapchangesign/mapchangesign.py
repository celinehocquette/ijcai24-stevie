import random

from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_element=-MAX_ELEMENT)
    y = list([-a for a in x])
    return f'mapchangesign({x},{y})'


def gen_neg():
    x = gen_list(min_element=-MAX_ELEMENT)
    y = list([-a for a in x])
    while y == list([-u for u in x]):
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out1 = []
        for i, a in enumerate(x):
            if i in changes:
                u = random.random()
                if u < 0.8:
                    out1.append(x[i])
                else:
                    out1.append(random.randint(0, MAX_ELEMENT))
            else:
                out1.append(a)
        x = out1
    return f'mapchangesign({out1},{y})'

MAPCHANGESIGN = 'mapchangesign'

class MapChangeSign(ListProblem):
    def __init__(self):
        super().__init__(MAPCHANGESIGN, gen_pos, gen_neg, MAPCHANGESIGN, num_examples=[60, 60, 1000, 1000])

    
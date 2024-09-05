import random

from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_element=2)
    y = list([a-1 for a in x])
    return f'mapminusone({x},{y})'


def gen_neg():
    x = gen_list(min_element=2)
    y = list([a-1 for a in x])
    while y == list([u-1 for u in x]):
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out1 = []
        for i, a in enumerate(x):
            if i in changes:
                out1.append(random.randint(1, MAX_ELEMENT))
            else:
                out1.append(a)
        x = out1
    return f'mapminusone({out1},{y})'

MAPMINUSONE = 'mapminusone'

class MapMinusOne(ListProblem):
    def __init__(self):
        super().__init__(MAPMINUSONE, gen_pos, gen_neg, MAPMINUSONE, num_examples=[60, 60, 1000, 1000])

    
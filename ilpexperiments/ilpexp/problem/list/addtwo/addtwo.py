import random

from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list()
    y = list([a+2 for a in x])
    return f'addtwo({x},{y})'


def gen_neg():
    x = gen_list()
    y = list([a+2 for a in x])
    while y == list([u+2 for u in x]):
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out1 = []
        for i, a in enumerate(x):
            if i in changes:
                out1.append(random.randint(1, MAX_ELEMENT))
            else:
                out1.append(a)
        x = out1
    return f'addtwo({out1},{y})'

ADDTWO = 'addtwo'

class AddTwo(ListProblem):
    def __init__(self):
        super().__init__(ADDTWO, gen_pos, gen_neg, ADDTWO, num_examples=[60, 60, 1000, 1000])

    
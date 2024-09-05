import random

from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list()
    y = list([a+5 for a in x])
    return f'addfive({x},{y})'


def gen_neg():
    x = gen_list()
    y = list([a+5 for a in x])
    while y == list([u+5 for u in x]):
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out1 = []
        for i, a in enumerate(x):
            if i in changes:
                out1.append(random.randint(1, MAX_ELEMENT))
            else:
                out1.append(a)
        x = out1
    return f'addfive({out1},{y})'

ADDFIVE = 'addfive'

class AddFive(ListProblem):
    def __init__(self):
        super().__init__(ADDFIVE, gen_pos, gen_neg, ADDFIVE)

    
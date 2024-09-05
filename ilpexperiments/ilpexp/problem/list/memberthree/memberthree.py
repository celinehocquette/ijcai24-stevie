import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list()
    i = random.randint(0, len(x)-1)
    x[i] = 3
    return f'memberthree({x})'

def gen_neg():
    x = gen_list()
    for i in range(len(x)):
        if x[i] == 3:
            x[i] = random.choice([k for k in range(0, MAX_ELEMENT+1) if not k == 3])
    return f'memberthree({x})'

MEMBERTHREE = 'memberthree'

class MemberThree(ListProblem):
    def __init__(self):
        super().__init__(MEMBERTHREE, gen_pos, gen_neg, MEMBERTHREE)

    
import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list()
    i = random.randint(0, len(x)-1)
    x[i] = 0
    return f'memberzero({x})'

def gen_neg():
    x = gen_list()
    for i in range(len(x)):
        if x[i] == 0:
            x[i] = random.choice([k for k in range(0, MAX_ELEMENT+1) if not k == 0])
    return f'memberzero({x})'

MEMBERZERO = 'memberzero'

class MemberZero(ListProblem):
    def __init__(self):
        super().__init__(MEMBERZERO, gen_pos, gen_neg, MEMBERZERO)

    
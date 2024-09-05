import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list()
    i = random.randint(0, len(x)-1)
    x[i] = 4
    return f'memberfour({x})'

def gen_neg():
    x = gen_list()
    for i in range(len(x)):
        if x[i] == 4:
            x[i] = random.choice([k for k in range(0, MAX_ELEMENT+1) if not k == 4])
    return f'memberfour({x})'

MEMBERFOUR = 'memberfour'

class MemberFour(ListProblem):
    def __init__(self):
        super().__init__(MEMBERFOUR, gen_pos, gen_neg, MEMBERFOUR)

    
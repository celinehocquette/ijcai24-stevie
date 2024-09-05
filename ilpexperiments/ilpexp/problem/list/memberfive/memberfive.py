import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list()
    i = random.randint(0, len(x)-1)
    x[i] = 5
    return f'memberfive({x})'

def gen_neg():
    x = gen_list()
    for i in range(len(x)):
        if x[i] == 5:
            x[i] = random.choice([k for k in range(0, MAX_ELEMENT+1) if not k == 5])
    return f'memberfive({x})'

MEMBERFIVE = 'memberfive'

class MemberFive(ListProblem):
    def __init__(self):
        super().__init__(MEMBERFIVE, gen_pos, gen_neg, MEMBERFIVE)

    
import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_element=-MAX_ELEMENT)
    i = random.randint(0, len(x)-1)
    x[i] = -1
    return f'memberminusone({x})'

def gen_neg():
    x = gen_list(min_element=-MAX_ELEMENT)
    for i in range(len(x)):
        if x[i] == -1:
            x[i] = random.choice([k for k in range(0, MAX_ELEMENT+1) if not k == -1])
    return f'memberminusone({x})'

MEMBERMINUSONE = 'memberminusone'

class MemberMinusOne(ListProblem):
    def __init__(self):
        super().__init__(MEMBERMINUSONE, gen_pos, gen_neg, MEMBERMINUSONE)

    
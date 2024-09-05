import random
from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list()
    i = random.randint(0, len(x)-1)
    x[i] = random.choice([x for x in range(1, MAX_ELEMENT+1) if x % 2 == 0])
    return f'membereven({x})'

def gen_neg():
    x = gen_list()
    for i in range(len(x)):
        if x[i] % 2 == 0:
            x[i] = random.choice([x for x in range(1, MAX_ELEMENT+1) if x % 2 != 0])
    return f'membereven({x})'

MEMBEREVEN = 'membereven'

class MemberEven(ListProblem):
    def __init__(self):
        super().__init__(MEMBEREVEN, gen_pos, gen_neg, MEMBEREVEN)

    
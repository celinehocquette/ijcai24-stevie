import random
from ..list import ListProblem, gen_list, MAX_ELEMENT


def gen_pos():
    x = gen_list(min_len=2, max_element=MAX_ELEMENT//3)
    if x[0] > MAX_ELEMENT-3*len(x):
        x[0] = random.choice([k for k in range(MAX_ELEMENT) if k < MAX_ELEMENT - len(x)])
    for i in range(1, len(x)):
        x[i] = x[i-1]+3
    return f'increment_seq3({x})'


def gen_neg():
    x = gen_list(min_len=2, max_element=MAX_ELEMENT//3)
    if x[0] > MAX_ELEMENT-3*len(x):
        x[0] = random.choice([k for k in range(MAX_ELEMENT) if k < MAX_ELEMENT - len(x)])
    for i in range(1, len(x)):
        x[i] = x[i - 1] + 3
    i = random.randint(0, len(x)-1)
    x[i] = random.choice([k for k in range(MAX_ELEMENT) if k != x[i]])
    return f'increment_seq3({x})'

INCREMENT_SEQ3 = 'increment_seq3'


class IncrementSeq3(ListProblem):
    def __init__(self):
        super().__init__(INCREMENT_SEQ3, gen_pos, gen_neg, INCREMENT_SEQ3)

    
import random
from ..list import ListProblem, gen_list, MAX_ELEMENT


def gen_pos():
    x = gen_list(min_len=2, max_element=MAX_ELEMENT//2)
    if x[0] > MAX_ELEMENT-2*len(x):
        x[0] = random.choice([k for k in range(MAX_ELEMENT) if k < MAX_ELEMENT - len(x)])
    for i in range(1, len(x)):
        x[i] = x[i-1]+2
    return f'increment_seq2({x})'


def gen_neg():
    x = gen_list(min_len=2, max_element=MAX_ELEMENT//2)
    if x[0] > MAX_ELEMENT-2*len(x):
        x[0] = random.choice([k for k in range(MAX_ELEMENT) if k < MAX_ELEMENT - len(x)])
    for i in range(1, len(x)):
        x[i] = x[i - 1] + 2
    i = random.randint(0, len(x)-1)
    x[i] = random.choice([k for k in range(MAX_ELEMENT) if k != x[i]])
    return f'increment_seq2({x})'

INCREMENT_SEQ2 = 'increment_seq2'


class IncrementSeq2(ListProblem):
    def __init__(self):
        super().__init__(INCREMENT_SEQ2, gen_pos, gen_neg, INCREMENT_SEQ2)

    
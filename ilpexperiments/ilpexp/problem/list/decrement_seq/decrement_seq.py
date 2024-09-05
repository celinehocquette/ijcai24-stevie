import random
from ..list import ListProblem, gen_list, MAX_ELEMENT


def gen_pos():
    x = gen_list(min_len=2)
    if x[0] < len(x):
        x[0] = random.choice([k for k in range(MAX_ELEMENT) if k > len(x)])
    for i in range(1, len(x)):
        x[i] = x[i-1]-1
    return f'decrement_seq({x})'


def gen_neg():
    x = gen_list(min_len=2)
    if x[0] < len(x):
        x[0] = random.choice([k for k in range(MAX_ELEMENT) if k > len(x)])
    for i in range(1, len(x)):
        x[i] = x[i-1] - 1
    i = random.randint(0, len(x)-1)
    x[i] = random.choice([k for k in range(MAX_ELEMENT) if k != x[i]])
    return f'decrement_seq({x})'

DECREMENT_SEQ = 'decrement_seq'


class DecrementSeq(ListProblem):
    def __init__(self):
        super().__init__(DECREMENT_SEQ, gen_pos, gen_neg, DECREMENT_SEQ)

    
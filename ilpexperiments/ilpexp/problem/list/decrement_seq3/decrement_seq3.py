import random
from ..list import ListProblem, gen_list, MAX_ELEMENT


def gen_pos():
    x = gen_list(min_len=2, max_len=MAX_ELEMENT//3)
    x[0] = random.choice([k for k in range(4*len(x)) if k > 3*len(x)])
    for i in range(1, len(x)):
        x[i] = x[i-1]-3
    return f'decrement_seq3({x})'


def gen_neg():
    x = gen_list(min_len=2, max_len=MAX_ELEMENT//3)
    x[0] = random.choice([k for k in range(4*len(x)) if k > 3*len(x)])
    for i in range(1, len(x)):
        x[i] = x[i-1] - 3
    i = random.randint(0, len(x)-1)
    x[i] = random.choice([k for k in range(4*len(x)) if k != x[i]])
    return f'decrement_seq3({x})'

DECREMENT_SEQ3 = 'decrement_seq3'


class DecrementSeq3(ListProblem):
    def __init__(self):
        super().__init__(DECREMENT_SEQ3, gen_pos, gen_neg, DECREMENT_SEQ3)

    
import random
from ..list import ListProblem, gen_list, MAX_ELEMENT


def gen_pos():
    x = gen_list(min_len=2, max_len=MAX_ELEMENT//2)
    x[0] = random.choice([k for k in range(4*len(x)) if k > 2*len(x)])
    for i in range(1, len(x)):
        x[i] = x[i-1]-2
    return f'decrement_seq2({x})'


def gen_neg():
    x = gen_list(min_len=2, max_len=MAX_ELEMENT//2)
    x[0] = random.choice([k for k in range(4*len(x)) if k > 2*len(x)])
    for i in range(1, len(x)):
        x[i] = x[i-1] - 2
    i = random.randint(0, len(x)-1)
    x[i] = random.choice([k for k in range(4*len(x)) if k != x[i]])
    return f'decrement_seq2({x})'

DECREMENT_SEQ2 = 'decrement_seq2'


class DecrementSeq2(ListProblem):
    def __init__(self):
        super().__init__(DECREMENT_SEQ2, gen_pos, gen_neg, DECREMENT_SEQ2)

    
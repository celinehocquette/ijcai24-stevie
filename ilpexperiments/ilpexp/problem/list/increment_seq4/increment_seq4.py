import random
from ..list import ListProblem, gen_list, MAX_ELEMENT


def gen_pos():
    x = gen_list(min_len=2, max_element=MAX_ELEMENT//3)
    for i in range(1, len(x)):
        x[i] = x[i-1]+4
    return f'increment_seq4({x})'


def gen_neg():
    x = gen_list(min_len=2, max_element=MAX_ELEMENT//3)
    for i in range(1, len(x)):
        x[i] = x[i - 1] + 4
    i = random.randint(0, len(x)-1)
    x[i] = random.choice([k for k in range(MAX_ELEMENT) if k != x[i]])
    return f'increment_seq4({x})'

INCREMENT_SEQ4 = 'increment_seq4'


class IncrementSeq4(ListProblem):
    def __init__(self):
        super().__init__(INCREMENT_SEQ4, gen_pos, gen_neg, INCREMENT_SEQ4)

    
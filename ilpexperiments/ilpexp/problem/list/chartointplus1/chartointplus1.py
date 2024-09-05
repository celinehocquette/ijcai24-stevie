import random
import string

from ..list import ListProblem, MAX_LIST_SIZE


def gen_pos():
    x, y = gen_pos_pair()
    return f'chartointplus1({x},{y})'


def gen_pos_pair():
    n = random.randint(1, MAX_LIST_SIZE + 1)
    x = [random.choice(string.ascii_lowercase) for _ in range(n)]
    y = list([ord(a)+1 for a in x])
    return x, y


def gen_neg():
    x, y = gen_pos_pair()
    while y == list([ord(a)+1 for a in x]):
        num_mutations = random.randint(1, len(x))
        changes = set(random.sample(range(len(x)), k=num_mutations))
        out = []
        for i, a in enumerate(y):
            if i in changes:
                out.append(random.randint(1, 28))
            else:
                out.append(a)
        y = out
    return f'chartointplus1({x},{y})'


CHARTOINTPLUS1 = 'chartointplus1'


class CharToIntPlus1(ListProblem):
    def __init__(self):
        super().__init__(CHARTOINTPLUS1, gen_pos, gen_neg, CHARTOINTPLUS1)


import random

from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=2)
    for i, a in enumerate(x):
        if a == 4:
            x[i] = random.choice([u for u in range(MAX_ELEMENT) if u != 4])
    k = random.randint(1, len(x)-1)
    x[k] = 4
    i = 0
    while i < len(x) and x[i] != 4:
        i += 1
    y = x[i:]
    return f'dropuntilfour({x},{y})'

def gen_neg():
    x = gen_list(min_len=2)
    for i, a in enumerate(x):
        if a == 4:
            x[i] = random.choice([u for u in range(MAX_ELEMENT) if u != 4])
    k = random.randint(1, len(x)-1)
    x[k] = 4
    i = 0
    while i < len(x) and x[i] != 4:
        i += 1
    k = random.choice([j for j in range(len(x)) if j != i])
    return f'dropuntilfour({x},{x[k:]})'

DROP_UNTIL_FOUR = 'dropuntilfour'

class DropUntilFour(ListProblem):
    def __init__(self):
        super().__init__(DROP_UNTIL_FOUR, gen_pos, gen_neg, DROP_UNTIL_FOUR, num_examples=[60, 60, 1000, 1000])

    
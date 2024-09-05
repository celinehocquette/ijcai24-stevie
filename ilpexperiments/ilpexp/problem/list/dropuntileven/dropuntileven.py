import random

from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos():
    x = gen_list(min_len=2)
    for i, a in enumerate(x):
        if a % 2 == 0:
            x[i] = random.choice([u for u in range(MAX_ELEMENT) if u % 2 == 1])
    k = random.randint(1, len(x)-1)
    x[k] = random.choice([u for u in range(MAX_ELEMENT) if u % 2 == 0])
    i = 0
    while i < len(x) and x[i] % 2 != 0:
        i += 1
    y = x[i:]
    return f'dropuntileven({x},{y})'

def gen_neg():
    x = gen_list(min_len=2)
    for i, a in enumerate(x):
        if a % 2 == 0:
            x[i] = random.choice([u for u in range(MAX_ELEMENT) if u % 2 == 1])
    k = random.randint(1, len(x)-1)
    x[k] = random.choice([u for u in range(MAX_ELEMENT) if u % 2 == 0])
    l = random.choice([j for j in range(len(x)) if j != k])
    return f'dropuntileven({x},{x[l:]})'

DROP_UNTIL_EVEN = 'dropuntileven'

class DropUntilEven(ListProblem):
    def __init__(self):
        super().__init__(DROP_UNTIL_EVEN, gen_pos, gen_neg, DROP_UNTIL_EVEN)

    
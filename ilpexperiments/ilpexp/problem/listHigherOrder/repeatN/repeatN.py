import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE

def gen_pos():
    n = random.randint(1, MAX_LIST_SIZE+1)
    x = random.randint(1, MAX_ELEMENT+1)
    xs = [x for _ in range(n)]
    return f'f([{n}],{x},{xs})'

def gen_neg():
    n = random.randint(1, MAX_LIST_SIZE+1)
    x = random.randint(1, MAX_ELEMENT+1)
    xs = [random.randint(1, MAX_ELEMENT+1) for _ in range(n)]
    while xs == [x for _ in range(n)]:
        xs = [random.randint(1, MAX_ELEMENT + 1) for _ in range(n)]
    return f'f([{n}],{x},{xs})'

REPEATN = 'repeatN'

class RepeatN(ListProblem):
    def __init__(self):
        super().__init__(REPEATN, gen_pos, gen_neg, REPEATN)

    
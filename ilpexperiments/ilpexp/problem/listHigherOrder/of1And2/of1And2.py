import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE

def gen_pos():
    n = random.randint(1, MAX_LIST_SIZE+1)
    xs = [random.randint(1, 2) for _ in range(n)]
    return f'f({xs})'

def gen_neg():
    n = random.randint(1, MAX_LIST_SIZE+1)
    xs = [random.randint(1, 2) for _ in range(n)]
    while set(xs).issubset({1, 2}):
        k = random.randint(0, len(xs)-1)
        xs[k] = random.choice([i for i in range(-10,1)]+[i for i in range(3,10)])
    return f'f({xs})'

OF1AND2 = 'of1And2'

class Of1And2(ListProblem):
    def __init__(self):
        super().__init__(OF1AND2, gen_pos, gen_neg, OF1AND2, num_examples=[20,20,100,100])

    
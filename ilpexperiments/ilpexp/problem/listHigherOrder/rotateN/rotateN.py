import random
from ..list import ListProblem, gen_list, MAX_ELEMENT, MAX_LIST_SIZE

def gen_pos():
    input = gen_list(min_len=2)
    n = random.randint(1, len(input)-1)
    output = input[n:]+input[:n]
    return f'f({n},{input},{output})'

def gen_neg():
    while True:
        input = gen_list(min_len=2)
        n = random.randint(1, len(input) - 1)
        output = input[n:] + input[:n]
        if any([input[k:] + input[:k] != output for k in range(len(input) - 1)]):
            while output == input[n:] + input[:n]:
                k = random.randint(0, len(input) - 1)
                output = output[k:] + output[:k]
            return f'f({n},{input},{output})'

ROTATEN = 'rotateN'

class RotateN(ListProblem):
    def __init__(self):
        super().__init__(ROTATEN, gen_pos, gen_neg, ROTATEN)

    
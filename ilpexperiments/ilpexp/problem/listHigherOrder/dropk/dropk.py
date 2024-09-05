import random
from ..list import ListProblem, gen_list, MAX_ELEMENT, MAX_LIST_SIZE

def gen_pos():
    input = gen_list(min_len=1)
    k = random.randint(0, len(input))
    output = input[k:]
    return f'dropk({k},{input},{output})'

def gen_neg():
    input = gen_list(min_len=1)
    k = random.randint(0, len(input))
    output = gen_list(min_len=1)
    while output == input[k:]:
        input = gen_list(min_len=1)
        k = random.randint(0, len(input))
        output = gen_list(min_len=1)
    return f'dropk({k},{input},{output})'

DROPK = 'dropk'

class DropK(ListProblem):
    def __init__(self):
        super().__init__(DROPK, gen_pos, gen_neg, DROPK)

    
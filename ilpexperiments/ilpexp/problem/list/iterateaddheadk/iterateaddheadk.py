import random
from ..list import ListProblem, MAX_ELEMENT, gen_list


def gen_pos():
    input = gen_list(min_len=2)
    n = random.randint(1, len(input)-1)
    output = input[:]
    output[0] += n
    return f'iterateaddheadk({n},{input},{output})'


def gen_neg():
    input = gen_list(min_len=2)
    n = random.randint(1, len(input)-1)
    output = input[:]
    output[0] += n
    output2 = output[:]
    while output2 == output:
        mutations = random.sample([i for i in range(len(input))], random.randint(1, len(input)))
        for j in mutations:
            output2[j] = random.randint(0, MAX_ELEMENT)
    return f'iterateaddheadk({n},{input},{output2})'


ITERATEADDHEADK = 'iterateaddheadk'


class IterateAddHeadK(ListProblem):
    def __init__(self):
        super().__init__(ITERATEADDHEADK, gen_pos, gen_neg, ITERATEADDHEADK)

    
import random
from ..list import ListProblem, MAX_ELEMENT, gen_list


def gen_pos():
    input = gen_list(min_len=2)
    n = random.randint(1, len(input)-1)
    output = input[:]
    output[-1] += 3*n
    return f'iterateaddlast3k({n},{input},{output})'


def gen_neg():
    input = gen_list(min_len=2)
    n = random.randint(1, len(input)-1)
    output = input[:]
    output[-1] += 3*n
    output2 = output[:]
    while output2 == output:
        mutations = random.sample([i for i in range(len(input))], random.randint(1, len(input)))
        for j in mutations:
            output2[j] = random.randint(0, MAX_ELEMENT)
    return f'iterateaddlast3k({n},{input},{output2})'


ITERATEADDLAST3K = 'iterateaddlast3k'


class IterateAddLast3K(ListProblem):
    def __init__(self):
        super().__init__(ITERATEADDLAST3K, gen_pos, gen_neg, ITERATEADDLAST3K)

    
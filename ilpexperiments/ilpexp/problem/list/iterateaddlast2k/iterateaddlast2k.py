import random
from ..list import ListProblem, MAX_ELEMENT, gen_list


def gen_pos():
    input = gen_list(min_len=2)
    n = random.randint(1, len(input)-1)
    output = input[:]
    output[-1] += 2*n
    return f'iterateaddlast2k({n},{input},{output})'


def gen_neg():
    input = gen_list(min_len=2)
    n = random.randint(1, len(input)-1)
    output = input[:]
    output[-1] += 2*n
    output2 = output[:]
    while output2 == output:
        mutations = random.sample([i for i in range(len(input))], random.randint(1, len(input)))
        for j in mutations:
            output2[j] = random.randint(0, MAX_ELEMENT)
    return f'iterateaddlast2k({n},{input},{output2})'


ITERATEADDLAST2K = 'iterateaddlast2k'


class IterateAddLast2K(ListProblem):
    def __init__(self):
        super().__init__(ITERATEADDLAST2K, gen_pos, gen_neg, ITERATEADDLAST2K)

    
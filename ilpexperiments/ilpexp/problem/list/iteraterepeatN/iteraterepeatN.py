import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE


def gen_pos():
    input = random.randint(0, MAX_ELEMENT)
    n = random.randint(1, MAX_LIST_SIZE-1)
    output = [input for _ in range(n+1)]
    return f'iteraterepeatN({n},[{input}],{output})'


def gen_neg():
    input = random.randint(0, MAX_ELEMENT)
    n = random.randint(1, MAX_LIST_SIZE-1)
    output = [input for _ in range(n+1)]
    x = random.random()
    if x < 0.5:
        k = random.randint(0, len(output)-1)
        while k == n:
            k = random.randint(0, len(output)-1)
        return f'iteraterepeatN({k},[{input}],{output})'
    else:
        output2 = output[:]
        while output2 == output:
            mutations = random.sample([i for i in range(len(output))], random.randint(1, len(output)))
            for j in mutations:
                output2[j] = random.randint(0, MAX_ELEMENT)
        return f'iteraterepeatN({n},[{input}],{output2})'


ITERATEREPEATN = 'iteraterepeatN'


class IterateRepeatN(ListProblem):
    def __init__(self):
        super().__init__(ITERATEREPEATN, gen_pos, gen_neg, ITERATEREPEATN)

    
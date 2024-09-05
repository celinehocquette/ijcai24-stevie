import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE, gen_list


def gen_pos():
    x = gen_list(min_len=1, max_len=MAX_LIST_SIZE, min_element=4, max_element=MAX_ELEMENT)
    return f'allgeqfour({x})'


def gen_neg():
    x = gen_list(min_len=1, max_len=MAX_LIST_SIZE, min_element=4, max_element=MAX_ELEMENT)
    num_mutations = random.randint(1, min(len(x), 3))
    changes = set(random.sample(range(len(x)), k=num_mutations))
    out = []
    for i, x in enumerate(x):
        if i in changes:
            out.append(random.randint(0, 3))
        else:
            out.append(x)
    return f'allgeqfour({out})'

ALLGEQFOUR = 'allgeqfour'

class AllGeqFour(ListProblem):
    def __init__(self):
        super().__init__(ALLGEQFOUR, gen_pos, gen_neg, ALLGEQFOUR)

    
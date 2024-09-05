import random
from functools import partial
from ..list import ListProblem, gen_list

def gen_pos(k):
    x = gen_list(min_len=1)
    y = x[:]
    y[-1] += k
    return f'addlast{k}({x},{y})'

def gen_neg(k):
    x = gen_list(min_len=1)
    m = random.choice([i for i in range(0, len(x)) if i != k])
    y = x[:]
    y[-1] += m
    return f'addlast{k}({x},{y})'


class AddLastK(ListProblem):
    def __init__(self, k):
        self.taskname = f"addlast{k}"
        gen_pos_partial = partial(gen_pos, k)
        gen_neg_partial = partial(gen_neg, k)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname)

    
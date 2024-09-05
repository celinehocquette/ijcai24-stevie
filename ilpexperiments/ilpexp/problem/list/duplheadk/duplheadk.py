import random
from functools import partial
from ..list import ListProblem, gen_list

def gen_pos(k):
    x = gen_list(min_len=1)
    y = [x[0] for _ in range(k)] + x
    return f'duplheadk{k}({x},{y})'

def gen_neg(k):
    x = gen_list(min_len=1)
    m = random.choice([i for i in range(0, len(x)) if i != k])
    y = [x[0] for _ in range(m)] + x
    return f'duplheadk{k}({x},{y})'


class DuplHeadK(ListProblem):
    def __init__(self, k):
        self.taskname = f"duplheadk{k}"
        gen_pos_partial = partial(gen_pos, k)
        gen_neg_partial = partial(gen_neg, k)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname)

    
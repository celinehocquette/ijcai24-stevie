import random
from functools import partial
from ..list import ListProblem, gen_list

def gen_pos(k):
    x = gen_list(min_len=k+1)
    return f'dropfirst{k}({x},{x[k:]})'

def gen_neg(k):
    x = gen_list(min_len=k+1)
    y = random.randint(0, len(x))
    m = random.choice([i for i in range(0, len(x)) if i != k])
    return f'dropfirst{k}({x},{x[m:]})'


class DropFirstK(ListProblem):
    def __init__(self, k):
        self.taskname = f"dropfirst{k}"
        gen_pos_partial = partial(gen_pos, k)
        gen_neg_partial = partial(gen_neg, k)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname)

    
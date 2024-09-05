import random
from functools import partial

from ..list import ListProblem, gen_list, MAX_ELEMENT

def gen_pos(member1, member2):
    x = gen_list(min_len=2)
    i, j = random.sample(list(range(0,len(x))), 2)
    x[i] = member1
    x[j] = member2
    return f'twomembers_{member1}_{member2}({x})'

def gen_neg(member1, member2):
    x = gen_list(min_len=2)
    i, j = random.sample(list(range(0, len(x))), 2)
    x[i] = member1
    x[j] = member2
    n = random.random()
    if n > 0.5:
        for i in range(len(x)):
            if x[i] == member1:
                x[i] = random.choice([k for k in range(0, MAX_ELEMENT+1) if not k == member1])
    else:
        for i in range(len(x)):
            if x[i] == member2:
                x[i] = random.choice([k for k in range(0, MAX_ELEMENT+1) if not k == member2])
    return f'twomembers_{member1}_{member2}({x})'


class TwoMembers(ListProblem):
    def __init__(self, member1, member2):
        self.taskname = f"twomembers_{member1}_{member2}"
        gen_pos_partial = partial(gen_pos, member1, member2)
        gen_neg_partial = partial(gen_neg, member1, member2)
        super().__init__(self.taskname, gen_pos_partial, gen_neg_partial, self.taskname)

    
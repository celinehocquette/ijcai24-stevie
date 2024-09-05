from ..chess import ChessProblem, gen_random_board
import random

def gen_pos():
    x = gen_random_board()
    for [p, id, i, j] in x:
        if j == 8:
            return gen_pos()
    y = []
    for [p, id, i, j] in x:
        if p == 'p':
            y.append([p, id, i, j+1])
    return f'chessmapfilter1({x}, {y})'


def gen_neg():
    while True:
        x = gen_random_board()
        y = []
        for [p, id, i, j] in x:
            if j == 8:
                return gen_neg()
        for [p, id, i, j] in x:
            if p == 'p':
                y.append([p, id, i, j+1])
        ignored = random.sample(list(range(len(x))), random.randint(1, len(x)))
        z = [[id, p, i, j+1] for i, [id, p, i, j] in enumerate(x) if i not in ignored]
        u = [[id, p, i, j] for [id, p, i, j] in z if p[0] != 'p']
        if not y == u:
            return f"chessmapfilter1({x}, {u})"


MAPFILTER1 = 'chessmapfilter1'


class MapFilter1Problem(ChessProblem):
    def __init__(self):
        super().__init__(MAPFILTER1, gen_pos, gen_neg, MAPFILTER1, num_examples=[50, 50, 1000, 1000])


from ..chess import ChessProblem, gen_random_board


def gen_pos():
    x = gen_random_board()
    for [p, id, i, j] in x:
        if j == 7 or j == 8:
            return gen_pos()
    y = []
    for [id, p, i, j] in x:
        if p[0] == 'p':
            y.append([id, p, i, 8])
    return f'chessmapfilteruntil1({x}, {y})'


def gen_neg():
    while True:
        x = gen_random_board()
        y = gen_random_board()
        for [p, id, i, j] in x:
            if j == 7 or j == 8:
                return gen_neg()
        z = []
        for [id, p, i, j] in x:
            if p[0] == 'p':
                z.append([id, p, i, 8])
        if not y == z:
            return f"chessmapfilteruntil1({x}, {y})"


MAPFILTERUNTIL1 = 'chessmapfilteruntil1'


class MapFilterUntil1Problem(ChessProblem):
    def __init__(self):
        super().__init__(MAPFILTERUNTIL1, gen_pos, gen_neg, MAPFILTERUNTIL1)


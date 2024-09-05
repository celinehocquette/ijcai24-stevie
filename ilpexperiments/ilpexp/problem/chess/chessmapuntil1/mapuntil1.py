from ..chess import ChessProblem, gen_random_board


def gen_pos():
    x = gen_random_board()
    y = []
    for [id, p, i, j] in x:
        if j == 8:
            return gen_pos()
    for [id, p, i, j] in x:
        y.append([id, p, i, 8])
    return f'chessmapuntil1({x}, {y})'


def gen_neg():
    while True:
        x = gen_random_board()
        y = gen_random_board()
        z = []
        for [id, p, i, j] in x:
            if j == 8:
                return gen_neg()
        for [id, p, i, j] in x:
            z.append([id, p, i, 8])
        if not y == z:
            return f"chessmapuntil1({x}, {y})"


MAPUNTIL1 = 'chessmapuntil1'


class MapUntil1Problem(ChessProblem):
    def __init__(self):
        super().__init__(MAPUNTIL1, gen_pos, gen_neg, MAPUNTIL1)


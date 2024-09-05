import copy
import random

from ..chess import ChessProblem, gen_random_board


def gen_pos():
    x = gen_random_board()
    for [p, id, i, j] in x:
        if p == 'p' and j == 8:
            return gen_pos()
    y = []
    for [id, p, i, j] in x:
        if p[0] == 'p':
            y.append([id, p, i, 8])
        else:
            y.append([id, p, i, j])
    return f'chessoriginal({x}, {y})'


def gen_neg():
    while True:
        x = gen_random_board()
        for [p, id, i, j] in x:
            if p == 'p' and j == 8:
                return gen_neg()
        y = []
        for [id, p, i, j] in x:
            if p[0] == 'p':
                y.append([id, p, i, 8])
            else:
                y.append([id, p, i, j])
        n_pawn = len([i for i in range(len(y)) if y[i][0] == 'p'])
        if n_pawn < 1:
            return gen_neg()
        z = copy.deepcopy(y[:])
        k = random.choice([i for i in range(len(z)) if z[i][0] == 'p'])
        z[k][3] = random.randint(1, 8)
        if not y == z:
            return f"chessoriginal({x}, {z})"


CHESSORIGINAL = 'chessoriginal'


class ChessOriginal(ChessProblem):
    def __init__(self):
        super().__init__(CHESSORIGINAL, gen_pos, gen_neg, CHESSORIGINAL)


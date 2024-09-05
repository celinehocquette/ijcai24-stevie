from ..ascii import AsciiProblem, gen_state, print_vision
import random


def gen_pos():
    while True:
        _, _, width, height, board1 = gen_state()
        if width <= 5 or height <= 5:
            continue
        # for j in range(0, 5):
        #     board1[j] = 0
        board2 = board1[:]
        # for j in range(0, 5):
        #     board2[j] = 1
        state1 = f"w({0},{0},{width},{height},{board1})"
        state2 = f"w({5},{5},{width},{height},{board2})"
        # print_vision(width, height, board1)
        # print_vision(width, height, board2)
        return f"do5times({state1}, {state2})"


def gen_neg():
    while True:
        _, _, width, height, board1 = gen_state()
        if width < 5 or height < 5:
            continue
        # for j in range(0, 5):
        #     board1[j] = 0
        board2 = board1[:]
        # for j in range(0, 5):
        #     board2[j] = 1
        board3 = board2[:]
        k = random.randint(0, width)
        for _ in range(k):
            u = random.randint(0, width*height-1)
            board3[u] = board2[u] + 1 % 2
        if not board2 == board3:
            state1 = f"w({0},{0},{width},{height},{board1})"
            state2 = f"w({5},{5},{width},{height},{board3})"
            return f"do5times({state1}, {state2})"


DO5TIMES = 'do5times'


class Do5Times(AsciiProblem):
    def __init__(self):
        super().__init__(DO5TIMES, gen_pos, gen_neg, DO5TIMES)

    
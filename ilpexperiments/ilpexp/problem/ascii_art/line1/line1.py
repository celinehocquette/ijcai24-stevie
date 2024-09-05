from ..ascii import AsciiProblem, gen_state, print_vision
import random


def gen_pos():
    _, _, width, height, board1 = gen_state()
    i = random.randint(0, height-1)
    for j in range(0, width-1):
        board1[i*width+j] = 0
    board2 = board1[:]
    for j in range(width-1):
        board2[i*width+j] = 1
    state1 = f"w({0},{i},{width},{height},{board1})"
    state2 = f"w({width-1},{i},{width},{height},{board2})"
    # print_vision(width, height, board1)
    # print_vision(width, height, board2)
    return f"line1({state1}, {state2})"



def gen_neg():
    while True:
        _, _, width, height, board1 = gen_state()
        i = random.randint(0, height - 1)
        for j in range(0, width - 1):
            board1[i * width + j] = 0
        board2 = board1[:]
        for j in range(width - 1):
            board2[i * width + j] = 1
        board3 = board2[:]
        k = random.randint(0, width-1)
        for _ in range(k):
            u = random.randint(0, width-1)
            board3[i * width + u] = board2[i * width + u] + 1 % 2
        state1 = f"w({0},{i},{width},{height},{board1})"
        state2 = f"w({k+1},{i},{width},{height},{board3})"
        return f"line1({state1}, {state2})"


LINE1 = 'line1'


# line1(A,B):- ho_197(A,B,inv_ho_0,at_right).
# inv_ho_0(A,B):- draw1(A,C),move_right(C,B).

class Line1Problem(AsciiProblem):
    def __init__(self):
        super().__init__(LINE1, gen_pos, gen_neg, LINE1)

    
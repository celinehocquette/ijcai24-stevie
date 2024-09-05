from ..ascii import AsciiProblem, gen_state, print_vision, MIN_vision_SIZE, MAX_vision_SIZE
import random

# line2(A,B):- ho_197(A,B,inv_ho_0,at_right).
# inv_ho_0(A,B):- draw1(A,C),move_right(C,D),move_down(D,B).

def gen_pos():
    width = random.randint(MIN_vision_SIZE, MAX_vision_SIZE)
    _, _, width, height, board1 = gen_state(width=width, height=width)
    for j in range(0, width-1):
        board1[j*height+j] = 0
    board2 = board1[:]
    for j in range(0, width-1):
        board2[j*height+j] = 1
    state1 = f"w({0},{0},{width},{height},{board1})"
    state2 = f"w(_,_,{width},{height},{board2})"
    # print_vision(width, height, board1)
    # print_vision(width, height, board2)
    return f"line2({state1}, {state2})"


def gen_neg():
    while True:
        width = random.randint(MIN_vision_SIZE, MAX_vision_SIZE)
        _, _, width, height, board1 = gen_state(width=width, height=width)
        for j in range(0, width-1):
            board1[j * height + j] = 0
        board2 = board1[:]
        for j in range(0, width-1):
            board2[j * height + j] = 1
        board3 = board2[:]
        k = random.randint(0, width-1)
        for _ in range(k):
            u = random.randint(0, width-1)
            board3[u * height + u] = board2[u * height + u] + 1 % 2
        if not board2 == board3:
            state1 = f"w({0},{0},{width},{height},{board1})"
            state2 = f"w(_,_,{width},{height},{board3})"
            return f"line2({state1}, {state2})"


LINE2 = 'line2'


class Line2Problem(AsciiProblem):
    def __init__(self):
        super().__init__(LINE2, gen_pos, gen_neg, LINE2)

    
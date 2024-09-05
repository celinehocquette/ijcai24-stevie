import random
from ..list import ListProblem, MAX_ELEMENT, MAX_LIST_SIZE
import string


ALPHABET_SIZE = 100

def gen_pos():
    n = random.randint(1, MAX_LIST_SIZE+1)
    x = [random.choice([c for c in string.ascii_lowercase if c != 'y' and c != 'z']) for _ in range(n)]
    y = list([ord(a) for a in x])
    y = list(map(lambda a: a+2, y))
    y = list(map(chr, y))
    return f'f({x},{y})'

def gen_neg():
    n = random.randint(1, MAX_LIST_SIZE+1)
    x = [random.choice([c for c in string.ascii_lowercase if c != 'y' and c != 'z']) for _ in range(n)]
    y = list([ord(a) for a in x])
    y = list(map(lambda a: a+2, y))
    y = list(map(chr, y))
    z = y[:]
    while z == y:
        i = random.randint(0, len(x)-1)
        z[i] = random.choice(string.ascii_lowercase)
    return f'f({x},{z})'

ENCRYPTION = 'encryption'

class Encryption(ListProblem):
    def __init__(self):
        super().__init__(ENCRYPTION, gen_pos, gen_neg, ENCRYPTION)

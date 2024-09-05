import os
import random
import re

from .. import Problem, ProblemInstance, instance_path
from ...util import mkdir, mkfile, curr_dir_relative
from ...system import *

NUM_TRAIN_EXAMPLES = 10
NUM_TEST_EXAMPLES = 1000

DEFAULT_NUM_EXAMPLES = [NUM_TRAIN_EXAMPLES, NUM_TRAIN_EXAMPLES, NUM_TEST_EXAMPLES, NUM_TEST_EXAMPLES]

MAX_GRID_SIZE = 10
DRINKS = ['tea', 'coffee']


def gen_examples(i, fn):
    return [fn() for _ in range(i)]


def rand_drink_pref():
    return random.choice(DRINKS)


def format_examples_pl(data):
    def state_pp(st):
        places = "["+','.join("p({},{},{},{})".format(*pos) for pos in st[2]) + "]"
        return "s({},{},{})".format(st[0], st[1], places)
    return state_pp(data)


def gen_pos():
    spacesize = random.randrange(2, MAX_GRID_SIZE+1)
    prefs = [(i, rand_drink_pref()) for i in range(1, spacesize+1)]
    places1 = ((pos, pref, 'down', 'empty') for (pos, pref) in prefs)
    places2 = ((pos, pref, 'up', pref) for (pos, pref) in prefs)
    s1 = (1, spacesize+1, places1)
    s2 = (spacesize+1, spacesize+1, places2)
    return f"waiter2({format_examples_pl(s1)},{format_examples_pl(s2)})"


def gen_neg():
    spacesize = random.randrange(2, MAX_GRID_SIZE+1)

    def rand_place_pair(original_pref):
        x1 = random.choice(['up', 'down'])
        if x1 == 'down':
            return x1, 'empty'
        if original_pref == 'tea':
            return x1, 'coffee'
        return x1, 'tea'

    def perturbe(prefs):
        n = len(prefs)
        k = random.randrange(1, n)
        positions = set(random.sample(range(1, n+1), k))
        out = []
        for pos, pref in prefs:
            if pos not in positions:
                out.append((pos, pref, 'up', pref))
            else:
                out.append((pos, pref, *rand_place_pair(pref)))
        return out

    prefs = [(i, rand_drink_pref()) for i in range(1, spacesize+1)]
    places1 = ((pos, pref, 'down', 'empty') for (pos, pref) in prefs)
    places2 = perturbe(prefs)
    s1 = (1, spacesize+1, places1)
    s2 = (spacesize+1, spacesize+1, places2)
    return f"waiter2({format_examples_pl(s1)},{format_examples_pl(s2)})"


class WaiterProblem2(Problem):

    def __init__(self, num_examples=DEFAULT_NUM_EXAMPLES):
        super().__init__('waiter2')
        self.gen_pos = gen_pos
        self.gen_neg = gen_neg
        self.sub_dir = 'waiter2'
        self.num_examples = num_examples

    def generate_instances(self, system, output_path, trial, additional_bk=None, additional_bias=None,
                           processing=False, calling_diagram={}):

        pos_train_examples = gen_examples(self.num_examples[0], self.gen_pos)
        neg_train_examples = gen_examples(self.num_examples[1], self.gen_neg)
        pos_test_examples = gen_examples(self.num_examples[2], self.gen_pos)
        neg_test_examples = gen_examples(self.num_examples[3], self.gen_neg)

        data_path = instance_path(output_path, self, system, trial)
        test_settings = BasicTestSettings(
            exs_file=self.write_examples(mkdir(data_path, 'test'), pos_test_examples, neg_test_examples),
            bk_file=self.make_bk(data_path, additional_bk)
        )

        if isinstance(system, Popper):
            train_settings = self.generate_popper(data_path, pos_train_examples, neg_train_examples,
                                                  additional_bk, additional_bias, processing=processing,
                                                  calling_diagram=calling_diagram)

        return ProblemInstance(self, system, train_settings, test_settings, trial=trial)


    def bk_file(self):
        return curr_dir_relative('bk.pl')

    def make_bk(self, data_path, additional_bk):
        bk_file = mkfile(data_path, 'bk.pl')

        with open(self.bk_file(), 'r') as initial_bk:
            base_bk = initial_bk.read()

        with open(bk_file, 'w') as f:
            f.write(base_bk)
            f.write("\n")
            f.write("\n")
            if additional_bk:
                for line in additional_bk:
                    f.write(f'{line}')
        return bk_file


    def make_bias(self, data_path, initial_bias_file, additional_bias):
        bias_file = mkfile(data_path, 'bias.pl')

        with open(initial_bias_file, 'r') as initial_bias:
            base_bias = initial_bias.read()

        with open(bias_file, 'w') as f:
            f.write(base_bias)
            f.write("\n")
            f.write("\n")
            if additional_bias:
                for line in additional_bias:
                    f.write(f'{line}')
        return bias_file


    def write_examples(self, data_path, pos_examples, neg_examples, name="exs.pl"):
        exs_file = mkfile(data_path, name)
        with open(exs_file, 'w') as f:
            for example in pos_examples:
                f.write(f'pos({example}).\n')
            for example in neg_examples:
                f.write(f'neg({example}).\n')
        return exs_file

    def generate_popper(self, data_path, pos_examples, neg_examples, additional_bk, additional_bias,
                           processing=False, calling_diagram={}):

        if processing:
            with open(curr_dir_relative('popper-bias.pl')) as initial_bias_file:
                initial_bias = initial_bias_file.read()
                primitives = re.findall(r'body_pred\((\w*),([0-9]*)\)', initial_bias)
                primitives = [list(p) for p in primitives]
                primitives = [[a, int(b)] for [a, b] in primitives]

            saved_abs = []
            for line in additional_bias:
                if line.startswith('body_pred'):
                    ho = re.findall(r'body_pred\((\w*),([0-9]*),ho\)', line)
                    if all([p in primitives for _, p in enumerate(calling_diagram[ho[0][0]])]):
                        saved_abs += line
                else:
                    saved_abs += line
        else:
            saved_abs = additional_bias

        exs_file = self.write_examples(data_path, pos_examples, neg_examples)
        return PopperTrainSettings(
            exs_file=exs_file,
            bias_file=self.make_bias(data_path, curr_dir_relative('popper-bias.pl'), "".join(saved_abs)),
            bk_file=self.make_bk(data_path, additional_bk),
            stats_file=os.sep.join([data_path, 'stats.json'])
        )


# This is a bit of a hacky way to turn "pos(f(A,B)). " or "neg(f(A,B)). " into "f(A,B)" for Aleph.
def strip_examples(exs):
    return [s.strip()[4:-2] for s in exs]

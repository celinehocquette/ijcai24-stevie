import os
import random
import numpy as np
import re

from .. import Problem, ProblemInstance, instance_path
from ...util import mkdir, mkfile, curr_dir_relative
from ...system import *

NUM_TRAIN_EXAMPLES = 20
NUM_TEST_EXAMPLES = 1000

DEFAULT_NUM_EXAMPLES = [NUM_TRAIN_EXAMPLES, NUM_TRAIN_EXAMPLES, NUM_TEST_EXAMPLES, NUM_TEST_EXAMPLES]

MIN_vision_SIZE, MAX_vision_SIZE = 5, 15

def gen_state(width=None, height=None, min_size=MIN_vision_SIZE, max_size=MAX_vision_SIZE):
    if not width:
        width = np.random.randint(min_size, max_size+1)
    if not height:
        height = np.random.randint(min_size, max_size+1)
    x = np.random.randint(0, width-1)
    y = np.random.randint(0, height-1)
    return x, y, width, height, list(np.random.choice([0, 1], width*height))


def gen_empty_state(width=None, height=None, min_size=MIN_vision_SIZE, max_size=MAX_vision_SIZE):
    if not width:
        width = np.random.randint(min_size, max_size+1)
    if not height:
        height = np.random.randint(min_size, max_size+1)
    return 0, 0, width, height, [0]*width*height


def gen_examples(i, fn):
    return [fn() for _ in range(i)]


def print_vision(width, height, board):
    for i in range(height):
        print(board[i*width:(i*width)+width])
    print('')


class AsciiProblem(Problem):

    # num_examples is an array of four numbers: the number of positive and negative training examples
    # followed by the number of positive and negative testing examples.

    def __init__(self, name, gen_pos, gen_neg, sub_dir, num_examples=DEFAULT_NUM_EXAMPLES, parameter=None):
        super().__init__(name)
        self.gen_pos = gen_pos
        self.gen_neg = gen_neg
        self.sub_dir = sub_dir
        self.num_examples = num_examples
        self.parameter = parameter

    def generate_instances(self, system, output_path, trial=None, additional_bk=None, additional_bias=None,
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
                                                  additional_bk, additional_bias,
                                                  processing=processing, calling_diagram=calling_diagram)

        return ProblemInstance(self, system, train_settings, test_settings, trial=trial, parameter=self.parameter)

    def write_examples(self, data_path, pos_examples, neg_examples):
        exs_file = mkfile(data_path, 'exs.pl')
        with open(exs_file, 'w') as f:
            for example in pos_examples:
                f.write(f'pos({example}).\n')
            for example in neg_examples:
                f.write(f'neg({example}).\n')
        return exs_file

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


    ### POPPER

    def generate_popper(self, data_path, pos_examples, neg_examples, additional_bk, additional_bias, processing=False,
                            calling_diagram={}):
        with open(curr_dir_relative('popper-bias.pl')) as f1:
            initial_bias = f1.read()
        with open(curr_dir_relative(os.sep.join([self.sub_dir, 'popper-bias.pl']))) as f2:
            initial_bias += f2.read()
        if processing:
            primitives = re.findall(r'body_pred\((\w*),([0-9]*)\)', initial_bias)
            primitives = [list(p) for p in primitives]
            primitives = [[a, int(b)] for [a, b] in primitives]

            saved_abs = []
            for line in additional_bias:
                if line.startswith('body_pred'):
                    ho = re.findall(r'body_pred\((\w*),([0-9]*),ho\)', line)
                    if all([p in primitives for p in calling_diagram[ho[0][0]]]):
                        saved_abs += line
                else:
                    saved_abs += line
        else:
            saved_abs = additional_bias

        return PopperTrainSettings(
            exs_file=self.write_examples(data_path, pos_examples, neg_examples),
            bias_file=popper.generate_bias_file(
                data_path,
                curr_dir_relative('popper-bias.pl'),
                curr_dir_relative(os.sep.join([self.sub_dir, 'popper-bias.pl'])),
                additional_bias="".join(saved_abs)),
            bk_file=self.make_bk(data_path, additional_bk),
            stats_file=os.sep.join([data_path, 'stats.json']),
            eval_timeout=0.01
        )

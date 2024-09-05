import os
import random
import re

from .. import Problem, ProblemInstance, instance_path
from ...util import mkdir, mkfile, curr_dir_relative
from ...system import *

NUM_TRIALS = 10


def partition(xs, rate=50):
    k = int((len(xs) / 100) * rate)
    return xs[:k], xs[k:]


class StringProblem(Problem):

    def __init__(self, index):
        super().__init__(f"string{index}")
        self.parameter = index
        self.source_examples_file = os.sep.join([curr_dir_relative("examples"), f"{index}.pl"])

    def make_example(self, p):
        prefix = p.split("(")[0]
        input = p.split("[")[1].split("]")[0]
        output = p.split("[")[2].split("]")[0]
        input = list(map(self.myformat, input.split(",")))
        output = list(map(self.myformat, output.split(",")))
        input = '[' + ','.join(input) + ']'
        output = '[' + ','.join(output) + ']'
        # return f"{prefix}(f{self.parameter}(s([{input}],[{output}]),s([],[])))."
        return f"{prefix}(f{self.parameter}({input},{output}))."

    def myformat(self, c):
        c = c.replace(" ", "")
        if not c:
            return f"s(none)"
        elif c.isupper():
            return f"u({c.lower()})"
        elif c.islower():
            return f"l({c})"
        elif c.isnumeric():
            return f"n({c})"
        else:
            return f"o({c})"


    def generate_instances(self, system, output_path, trial=None, additional_bk=None, additional_bias=None,
                           processing=False, calling_diagram={}):

        pos = []
        neg = []
        with open(self.source_examples_file) as f:
            for line in f:
                line = line.strip()
                if line.startswith('pos'):
                    pos.append(line)
                elif line.startswith('neg'):
                    neg.append(line)

        pos = list(map(self.make_example, pos))
        neg = list(map(self.make_example, neg))

        random.shuffle(pos)
        random.shuffle(neg)

        train_pos, test_pos = partition(pos)
        train_neg, test_neg = partition(neg)

        data_path = instance_path(output_path, self, system, trial)

        test_settings = BasicTestSettings(
            exs_file=self.write_examples(data_path, test_pos, test_neg, name="test_exs.pl"),
            bk_file=self.make_bk(data_path, additional_bk)
        )

        train_exs_file = self.write_examples(data_path, train_pos, train_neg)

        if isinstance(system, Popper):
            train_settings = self.generate_popper(data_path, train_exs_file,
                                                  curr_dir_relative('popper-bias.pl'),
                                                  additional_bk, additional_bias,
                                                  processing=processing, calling_diagram=calling_diagram)

        return ProblemInstance(self, system, train_settings, test_settings, parameter=self.parameter)

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

    def write_examples(self, data_path, pos_examples, neg_examples, name="exs.pl"):
        exs_file = mkfile(data_path, name)
        with open(exs_file, 'w') as f:
            for example in pos_examples + neg_examples:
                f.write(f'{example}\n')
        return exs_file


    def make_bias_metagol(self, data_path, base_bias_file, additional_bias):
        bias_file = mkfile(data_path, 'metagol-prims.pl')

        with open(base_bias_file, 'r') as initial_bias:
            base_bias = initial_bias.read()

        with open(bias_file, 'w+') as f:
            f.write(base_bias)
            f.write("\n\n")
            if additional_bias:
                for line in additional_bias:
                    f.write(f'{line}')
        return bias_file

    def generate_popper(self, data_path, exs_file, source_bias_file, additional_bk, additional_bias, processing=False,
                        calling_diagram={}):

        if processing:
            with open(source_bias_file) as initial_bias_file:
                initial_bias = initial_bias_file.read()
                primitives = re.findall(r'body_pred\((\w*),([0-9]*)\)', initial_bias)
                primitives = [list(p) for p in primitives]
                primitives = [[a,int(b)] for [a,b] in primitives]

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

        saved_abs += f"head_pred(f{self.parameter},2).\n"
        saved_abs += f"type(f{self.parameter},(string,string)).\n"
        saved_abs += f"direction(f{self.parameter},(in,in)).\n"
        return PopperTrainSettings(
            exs_file=exs_file,
            bias_file=popper.generate_bias_file(data_path, source_bias_file,additional_bias="".join(saved_abs)),
            bk_file=self.make_bk(data_path, additional_bk),
            stats_file=os.sep.join([data_path, 'stats.json']),
            eval_timeout=1
        )


# This is a bit of a hacky way to turn "pos(f(A,B)). " or "neg(f(A,B)). " into "f(A,B)" for Aleph.
def strip_examples(exs):
    return [s.strip()[4:-2] for s in exs]
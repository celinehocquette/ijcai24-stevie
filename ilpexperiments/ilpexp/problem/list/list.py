import os
from os.path import exists
import random
import re

from .. import Problem, ProblemInstance, instance_path
from ...util import mkdir, mkfile, curr_dir_relative
from ...system import *

NUM_TRAIN_EXAMPLES = 10
NUM_TEST_EXAMPLES = 1000

DEFAULT_NUM_EXAMPLES = [NUM_TRAIN_EXAMPLES, NUM_TRAIN_EXAMPLES, NUM_TEST_EXAMPLES, NUM_TEST_EXAMPLES]

MAX_LIST_SIZE = 50
MAX_ELEMENT = 100
MAX_LISTS = 10


def gen_list(min_len=1, max_len=MAX_LIST_SIZE, min_element=0, max_element=MAX_ELEMENT):
    n = random.randint(min_len, max_len+1)
    return [random.randint(min_element, max_element) for _ in range(n)]


def gen_element(min_element=1, max_element=MAX_ELEMENT):
    return random.randint(min_element, max_element)


def gen_examples(i, fn):
    return [fn() for _ in range(i)]


class ListProblem(Problem):
    
    # num_examples is an array of four numbers: the number of positive and negative training examples
    # followed by the number of positive and negative testing examples.

    def __init__(self, name, gen_pos, gen_neg, sub_dir, num_examples=DEFAULT_NUM_EXAMPLES):
        super().__init__(name)
        self.name = name
        self.gen_pos = gen_pos
        self.gen_neg = gen_neg
        self.sub_dir = sub_dir
        self.num_examples = num_examples

    def generate_instances(self, system, output_path, trial=None, additional_bk="", additional_bias="",
                           processing=False, calling_diagram={}):
        pos_train_examples = gen_examples(self.num_examples[0], self.gen_pos)
        neg_train_examples = gen_examples(self.num_examples[1], self.gen_neg)
        pos_test_examples = gen_examples(self.num_examples[2], self.gen_pos)
        neg_test_examples = gen_examples(self.num_examples[3], self.gen_neg)

        data_path = instance_path(output_path, self, system)
        test_settings = BasicTestSettings(
            exs_file=self.write_examples(mkdir(data_path, 'test'), pos_test_examples, neg_test_examples),
            bk_file=self.make_bk(data_path, additional_bk)
        )

        if isinstance(system, Popper):
            train_settings = self.generate_popper(data_path, pos_train_examples, neg_train_examples,
                                                  additional_bk, additional_bias)

        return ProblemInstance(self, system, train_settings, test_settings, trial=trial)

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

    def make_bias_metagol(self, data_path, base_bias_file, problem_bias_file, additional_bias):
        bias_file = mkfile(data_path, 'metagol-prims.pl')

        with open(base_bias_file, 'r') as initial_bias:
            base_bias = initial_bias.read()

        if problem_bias_file:
            with open(problem_bias_file, 'r') as problem_bias:
                pb_bias = problem_bias.read()

        with open(bias_file, 'w+') as f:
            f.write(base_bias)
            f.write("\n")
            f.write("\n")
            if pb_bias:
                for line in pb_bias:
                    f.write(f'{line}')
            if additional_bias:
                for line in additional_bias:
                    f.write(f'{line}')
        return bias_file
    # POPPER
    def generate_popper(self, data_path, pos_examples, neg_examples, additional_bk, additional_bias):
        if self.name.startswith("list_of_lists") or self.name.startswith("filter") or self.name.startswith("count") \
                or self.name.startswith("twomembers") or self.name.startswith("dropfirst") or self.name.startswith("addhead")\
                or self.name.startswith("addlast") or self.name.startswith("repeatminuslast") or self.name.startswith("repeatminushead") or self.name.startswith("addnumber") or self.name.startswith("duplhead")\
                or self.name.startswith("encrypt") or self.name.startswith("memberoperation") or self.name.startswith("ifevenaddelseminus") \
                or self.name.startswith("seqseq") or self.name.startswith("rotateuntil") or self.name.startswith("mapfilter") \
                or self.name.startswith("mapcount") or self.name.startswith("mapfunc"):
            if self.name.startswith("list_of_lists_all") or self.name.startswith("list_of_lists_member"):
                additional_bias += f"\n\nhead_pred({self.name},1).\n"
                additional_bias += f"type({self.name},(list_of_lists,)).\n"
                additional_bias += f"direction({self.name},(in,)).\n\n"
            elif self.name.startswith("list_of_lists_map") or self.name.startswith("list_of_lists_filter"):
                if any(["max" in self.name, "min" in self.name, "sum" in self.name, "mult" in self.name, "min" in self.name,
                        "last" in self.name, "len" in self.name]):
                    additional_bias += f"\n\nhead_pred({self.name},2).\n"
                    additional_bias += f"type({self.name},(list_of_lists,list)).\n"
                    additional_bias += f"direction({self.name},(in,in)).\n\n"
                else:
                    additional_bias += f"\n\nhead_pred({self.name},2).\n"
                    additional_bias += f"type({self.name},(list_of_lists,list_of_lists)).\n"
                    additional_bias += f"direction({self.name},(in,in)).\n\n"
            elif self.name.startswith("list_of_lists_count"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list_of_lists,list)).\n"
                additional_bias += f"direction({self.name},(in,in)).\n\n"
            elif self.name.startswith("twomembers"):
                additional_bias += f"\n\nhead_pred({self.name},1).\n"
                additional_bias += f"type({self.name},(list,)).\n"
                additional_bias += f"direction({self.name},(in,)).\n\n"
            elif self.name.startswith("count"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,int)).\n"
                additional_bias += f"direction({self.name},(in,out)).\n\n"
            elif self.name.startswith("dropfirst"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,list)).\n"
                additional_bias += f"direction({self.name},(in,out)).\n\n"
            elif self.name.startswith("addhead") or self.name.startswith("addlast") or self.name.startswith("duplheadk") \
                    or self.name.startswith("repeatminuslast") or self.name.startswith("repeatminushead"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,list)).\n"
                additional_bias += f"direction({self.name},(in,out)).\n\n"
            elif self.name.startswith("addnumber"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(element,element)).\n"
                additional_bias += f"direction({self.name},(in,out)).\n\n"
            elif self.name.startswith("encrypt"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,list)).\n"
                additional_bias += f"direction({self.name},(in,in)).\n\n"
            elif self.name.startswith("memberoperation"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,element)).\n"
                additional_bias += f"direction({self.name},(in,out)).\n\n"
            elif self.name.startswith("ifevenaddelseminus"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(element,element)).\n"
                additional_bias += f"direction({self.name},(in,out)).\n\n"
            elif self.name.startswith("seqseq"):
                additional_bias += f"\n\nhead_pred({self.name},3).\n"
                additional_bias += f"type({self.name},(int,element,list)).\n"
                additional_bias += f"direction({self.name},(in,in,out)).\n\n"
            elif self.name.startswith("rotateuntil"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,list)).\n"
                additional_bias += f"direction({self.name},(in,out)).\n\n"
            elif self.name.startswith("mapfilter") or self.name.startswith("mapfunc"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,list)).\n"
                additional_bias += f"direction({self.name},(in,in)).\n\n"
            elif self.name.startswith("mapcount"):
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,int)).\n"
                additional_bias += f"direction({self.name},(in,in)).\n\n"
            else:
                additional_bias += f"\n\nhead_pred({self.name},2).\n"
                additional_bias += f"type({self.name},(list,list)).\n"
                additional_bias += f"direction({self.name},(in,out)).\n\n"
            task = self.name.split('_')[-1]

            task_bias = curr_dir_relative(os.sep.join([f"{task}", 'popper-bias.pl']))
            if exists(task_bias):
                with open(task_bias) as f:
                    lines = f.readlines()
                    i = 0
                    # !! assumes body_pred, type and directions declarations are next to each others
                    while i < len(lines):
                        if "body_pred" in lines[i]:
                            additional_bias += lines[i]
                            pred_name = lines[i].split("(")[1].split(",")[0]
                            assert pred_name in lines[i+1] and "type" in lines[i+1]
                            additional_bias += lines[i+1]
                            assert pred_name in lines[i+2] and "direction" in lines[i+2]
                            additional_bias += lines[i+2]
                            i += 3
                        else:
                            i += 1

        if self.name.startswith("filter") and "tail" in self.name:
            problem_bias = curr_dir_relative(os.sep.join(["filter_tail", 'popper-bias.pl']))
        elif self.name.startswith("filter"):
            problem_bias = curr_dir_relative(os.sep.join(["filter", f'popper-bias-{self.name.split("_")[-1]}.pl']))
        elif self.name.startswith("countsuccessor"):
            problem_bias = curr_dir_relative(os.sep.join(["countsuccessor", 'popper-bias.pl']))
        elif self.name.startswith("count"):
            problem_bias = curr_dir_relative(os.sep.join(["count", f'popper-bias-{self.name.split("_")[-1]}.pl']))
        elif self.name.startswith("twomembers"):
            problem_bias = curr_dir_relative(os.sep.join(["twomembers", 'popper-bias.pl']))
        elif self.name.startswith("dropfirst"):
            problem_bias = curr_dir_relative(os.sep.join(["dropfirstk", 'popper-bias.pl']))
        elif self.name.startswith("addhead"):
            problem_bias = curr_dir_relative(os.sep.join(["addheadk", 'popper-bias.pl']))
        elif self.name.startswith("addlast"):
            problem_bias = curr_dir_relative(os.sep.join(["addlastk", 'popper-bias.pl']))
        elif self.name.startswith("repeatminuslast"):
            problem_bias = curr_dir_relative(os.sep.join(["repeatminuslastk", 'popper-bias.pl']))
        elif self.name.startswith("repeatminushead"):
            problem_bias = curr_dir_relative(os.sep.join(["repeatminusheadk", 'popper-bias.pl']))
        elif self.name.startswith("duplhead"):
            problem_bias = curr_dir_relative(os.sep.join(["duplheadk", 'popper-bias.pl']))
        elif self.name.startswith("addnumber"):
            problem_bias = curr_dir_relative(os.sep.join(["addnumberk", 'popper-bias.pl']))
        elif self.name.startswith("list_of_lists"):
            problem_name = "_".join(self.name.split('_')[:-1])
            problem_bias = curr_dir_relative(os.sep.join([problem_name, 'popper-bias.pl']))
        elif self.name.startswith("encrypt_1"):
            problem_bias = curr_dir_relative(os.sep.join(["encrypt_1", 'popper-bias.pl']))
        elif self.name.startswith("encrypt_2"):
            problem_bias = curr_dir_relative(os.sep.join(["encrypt_2", 'popper-bias.pl']))
        elif self.name.startswith("memberoperation"):
            problem_bias = curr_dir_relative(os.sep.join(["memberoperation", 'popper-bias.pl']))
        elif self.name.startswith("ifevenaddelseminus"):
            problem_bias = curr_dir_relative(os.sep.join(["ifevenaddelseminus", 'popper-bias.pl']))
        elif self.name.startswith("seqseq"):
            problem_bias = curr_dir_relative(os.sep.join(["seqseqk", 'popper-bias.pl']))
        elif self.name.startswith("rotateuntil"):
            problem_bias = curr_dir_relative(os.sep.join(["rotateuntil", 'popper-bias.pl']))
        elif self.name.startswith("mapfunc"):
            problem_bias = curr_dir_relative(os.sep.join(["mapfunc", 'popper-bias.pl']))
        elif self.name.startswith("mapfilter"):
            problem_bias = curr_dir_relative(os.sep.join(["mapfilter", 'popper-bias.pl']))
        elif self.name.startswith("mapcount"):
            problem_bias = curr_dir_relative(os.sep.join(["mapcount", 'popper-bias.pl']))
        else:
            problem_bias = curr_dir_relative(os.sep.join([self.sub_dir, 'popper-bias.pl']))

        if self.name.startswith("filter"):
            base_bias = curr_dir_relative('popper-bias2.pl')
        else:
            base_bias = curr_dir_relative('popper-bias.pl')
        return PopperTrainSettings(
            exs_file=self.write_examples(data_path, pos_examples, neg_examples),
            bias_file=popper.generate_bias_file(
                data_path, 
                base_bias,
                problem_bias,
                additional_bias="".join(additional_bias)),
            bk_file=self.make_bk(data_path, additional_bk),
            stats_file=os.sep.join([data_path, 'stats.json'])
        )


import os
import json
import tempfile

from .. import System
from ...util import run_command, mkfile
from ...result import *

DEFAULT_TIMEOUT=30
DEFAULT_INSTALL_DIR='../Popper'
DEFAULT_SETTINGS={}

def generate_bias_file(data_path, base_bias_file, problem_bias_file=None, additional_bias=None):

    with open(base_bias_file, 'r') as f:
        base_bias = f.read()
    
    problem_bias = None
    if problem_bias_file and os.path.exists(problem_bias_file):
        with open(problem_bias_file, 'r') as f:
            problem_bias = f.read()

    bias_file = mkfile(data_path, 'bias.pl')

    with open(bias_file, 'w') as f:
        if problem_bias:
            f.write(problem_bias)
        f.write("\n\n")
        f.write(base_bias)
        f.write("\n\n")
        if additional_bias:
            f.write(additional_bias)
        f.write("\n\n")

    return bias_file

class Popper(System):
    def __init__(self, install_dir=DEFAULT_INSTALL_DIR, settings=DEFAULT_SETTINGS, id="popper", timeout=DEFAULT_TIMEOUT):
        super().__init__("popper", id)
        self.install_dir = install_dir
        self.settings = settings
        self.timeout = timeout

    def train(self, train_settings, added_bk=None, depth=None):

        added_preds = ""
        if added_bk:
            with open(added_bk, 'r') as more_bk:
                additional_bk = more_bk.readlines()
                for line in additional_bk:
                    [head,_] = process_clause(line)
                    pred, arity, _ = process_literal(head)
                    added_preds += f"body_pred({pred}, {arity}).\n"

            with open(train_settings.bk_file, "a+") as bk:
                bk.write(additional_bk)

        with open(train_settings.bias_file, 'r') as bias:
            lines = bias.readlines()
            new_lines = ""

            if depth:
                for line in lines:
                    if "max_clauses" not in line:
                        new_lines += line
                new_lines += f"\nmax_clauses({depth}).\n"
            else:
                new_lines = "".join(lines)

        with open(train_settings.bias_file, "w+") as bias:
            bias.write(new_lines)
            if added_preds:
                bias.write(added_preds)

        # reset stats file
        if os.path.exists(train_settings.stats_file):
            os.remove(train_settings.stats_file)

        final_settings = self.settings.copy()
        final_settings["--stats-file"] = train_settings.stats_file
        final_settings["--bk-file"] = train_settings.bk_file
        final_settings["--ex-file"] = train_settings.exs_file
        final_settings["--bias-file"] = train_settings.bias_file
        final_settings["--timeout"] = str(self.timeout)
        final_settings["--eval-timeout"] = str(train_settings.eval_timeout)

        # We give an arbitrary extra 10 seconds to the Popper run_command so Popper can timeout the result itself.
        import sys
        python_cmd = os.path.join(sys.exec_prefix, "bin", "python")
        python_file = os.sep.join([self.install_dir, 'popper.py'])
        run_command([python_cmd, python_file], final_settings, timeout=self.timeout + 10)

        stats = None
        if os.path.exists(train_settings.stats_file):
            with open(train_settings.stats_file, 'r') as f:
                stats = json.loads(f.read())
        
        code = None
        total_exec_time = self.timeout
        if stats:
            print('STATS')
            solution = stats["solution"]
            if solution:
                print('SOLUTION')
                code = solution["code"] if solution["is_solution"] else None
                if "total_exec_time" in solution:
                    total_exec_time = solution["total_exec_time"]

        return (code, total_exec_time, stats)

class PopperTrainSettings:
    def __init__(self, exs_file, bk_file, bias_file, stats_file, eval_timeout=0.01):
        self.exs_file = exs_file
        self.bk_file = bk_file
        self.bias_file = bias_file
        self.stats_file = stats_file
        self.eval_timeout = eval_timeout

BASIC_POPPER = Popper("./hopper", {"--debug":"", "--stats":""}, timeout=30)
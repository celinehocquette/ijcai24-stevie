import collections
import multiprocessing as mp
import shutil
import traceback
import sys
import os
import math
from collections import defaultdict
import time

import clingo
import random
import scipy.stats as stats
from time import perf_counter
from ..util import get_logger, mkfile
from ..result import write_result
from stevie.experiments.stevie.abstract import perform_abstraction
from .get_types_python import get_types, convert_to_atom
from .map_types import map_types
from ..system import *
import multiprocessing

from datetime import datetime

DEFAULT_OUTPUT_PATH = './results'
DEFAULT_BIAS = './ilpexperiments/ilpexp/runner/types.pl'
PREVISOULY_LEARNED = './ilpexperiments/ilpexp/runner/previously_learned_synthesis.pl'
PERFECT_ABS = "./ilpexperiments/ilpexp/runner/perfect_abstractions.pl"
PERFECT_ABS_BK = "./ilpexperiments/ilpexp/runner/perfect_abstractions_bk.pl"

def queue_to_list(q):
    mylist = []
    while q.qsize() != 0:
        mylist.append(q.get())
    return mylist


def partition(xs, rate=75):
    k = int((len(xs) * rate / 100))
    return xs[:k], xs[k:]


def read_results(results):
    accuracies = [r.accuracy for r in results]
    learning_times = [r.total_exec_time for r in results]
    solved = [1 if r.num_literals else 0 for r in results]
    prog_length = [r.num_literals for r in results if r.num_literals]
    return accuracies, learning_times, solved, prog_length


def generate_multiple_instances(problems, system, manual_abstractions=False, output_path=DEFAULT_OUTPUT_PATH,
                                trial=None, abstractions=[], hotypes={}, ho_directions={}, types_mapping=False,
                                processing=False):
    instances = []

    for problem in problems:
        bk, bias = "", ""
        if isinstance(system, Popper):
            if types_mapping:
                mapped_hotypes = map_types(problem, hotypes)
            else:
                mapped_hotypes = hotypes
            bias, bk, calling_diagram = make_bias_popper(abstractions, mapped_hotypes, ho_directions)

            if manual_abstractions:
                with open(PERFECT_ABS_BK) as abs_bk:
                    bk += "\n".join(abs_bk.readlines())
                with open(PERFECT_ABS) as abs_bias:
                    bias += "\n".join(abs_bias.readlines())

            print(f"generate instance {problem.name}")

        instances.append(problem.generate_instances(system, output_path, trial=trial, additional_bk=bk,
                                                    additional_bias=bias, processing=processing,
                                                    calling_diagram=calling_diagram))
    return instances


class MultiTaskStevie:
    def __init__(self, num_threads_train=None, num_threads_test=None, stevie=False):
        if num_threads_train is None:
            num_threads_train = math.ceil(mp.cpu_count() / 2.0)
        if num_threads_test is None:
            num_threads_test = math.ceil(mp.cpu_count() / 2.0)

        self.num_threads_train = num_threads_train
        self.num_threads_test = num_threads_test
        self.stevie = stevie

    def evaluate_transfer_problems(self, output_path, trial, batch, penalize_variables_transfer, system_test,
                                   transfer_problems, saved_programs, abstractions=False, manual_abstractions=False):

        accuracies_transfer, learning_times_transfer = collections.defaultdict(list), collections.defaultdict(list)
        solved_transfer, prog_length_transfer = collections.defaultdict(list), collections.defaultdict(list)

        output_path_trial = os.path.join(output_path, f"{trial}", f"{batch-1}")

        if not os.path.exists(os.path.join(output_path_trial, "transfer")):
            os.makedirs(os.path.join(os.path.join(output_path_trial, "transfer")))

        if abstractions:
            learned_programs_file = os.path.join(output_path_trial, "programs.pl")
            abstractions_transfer = os.path.join(output_path_trial, "abstractions.pl")
            refactored_theory_file_transfer = os.path.join(output_path_trial, "compressed_list_progs.pl")

            if isinstance(system_test, Popper):
                ho_types, ho_directions = get_types(DEFAULT_BIAS, refactored_theory_file_transfer,
                                                    learned_programs_file)
            else:
                ho_types, ho_directions = None, None
            with open(abstractions_transfer, "r") as f:
                abstrac = f.readlines()

        else:
            abstrac, ho_types, ho_directions = None, dict(), dict()

        tranfer_result_list = self.evaluate_tasks(os.path.join(output_path_trial, "transfer"), transfer_problems, system_test,
                                                  saved_programs, manual_abstractions=manual_abstractions, abstractions=abstrac,
                                                  hotypes=ho_types, ho_directions=ho_directions, types_mapping=True,
                                                  processing=True)

        for r in tranfer_result_list:
            accuracies_transfer[r.problem_name].append(r.accuracy)
        learning_times_transfer[r.problem_name].append(r.total_exec_time)
        if r.num_literals:
            prog_length_transfer[r.problem_name].append(r.num_literals)
            solved_transfer[r.problem_name].append(1)
        else:
            solved_transfer[r.problem_name].append(0)

        return accuracies_transfer, learning_times_transfer, prog_length_transfer, solved_transfer


    def evaluate_tasks(self, output_path, tasks, system, saved_programs, manual_abstractions=False, abstractions=[],
                       hotypes=None, ho_directions=None, types_mapping=False, processing=False, stevie=False):
        ctx = mp.get_context('spawn')
        instances = generate_multiple_instances(tasks, system, manual_abstractions=manual_abstractions,
                                                output_path=output_path, abstractions=abstractions, hotypes=hotypes,
                                                ho_directions=ho_directions, types_mapping=types_mapping, processing=processing)
        return self.run_tasks(ctx, instances, output_path, saved_programs, self.num_threads_test)


    def make_train_test_tasks(self, tasks, test_problems):
        random.shuffle(tasks)
        if not test_problems:
            return partition(tasks)
        else:
            return tasks, test_problems



    def run(self, n_trials, tasks, system_train, system_test, stevie_every_n_tasks, test_problems=None,
            transfer_problems=None, output_path=DEFAULT_OUTPUT_PATH, manual_abstractions=False, saved_programs=None,
            penalize_variables=False, penalize_variables_transfer=False, test_initial=False, previously_learned=False,
            initial_transfer=False):

        all_accuracies, all_learning_times, all_solved, all_prog_length, all_stevie_duration = [], [], [], [], []

        results_file = os.path.abspath(mkfile(output_path, "results.py"))
        open(results_file, "w").close()

        for trial in range(n_trials):
            all_accuracies.append([])
            all_learning_times.append([])
            all_solved.append([])
            all_prog_length.append([])

            output_path_trial = os.path.join(output_path, f"{trial}")
            if os.path.exists(output_path_trial):
                shutil.rmtree(output_path_trial)

            os.makedirs(output_path_trial)

            if transfer_problems and initial_transfer:
                accuracies_transfer, learning_times_transfer, prog_length_transfer, solved_transfer = self.evaluate_transfer_problems(
                    output_path, trial, 0, penalize_variables_transfer, system_test,
                    transfer_problems, saved_programs, abstractions=False, manual_abstractions=manual_abstractions)

            traintasks, holdouttasks = self.make_train_test_tasks(tasks, test_problems)
            print(f"number of train tasks: {len(traintasks)}")
            print(f"number of holdouttasks: {len(holdouttasks)}")
            with open(f"{output_path_trial}/stats.pl", "w+") as f:
                f.write(f"number of train tasks: {len(traintasks)}\n")
                f.write(f"number of holdouttasks: {len(holdouttasks)}")

            accuracies, learning_times, solved, stevie_duration, prog_length = [], [], [], [], []
            accuracies_train, learning_times_train = [], []

            logger = get_logger()

            # test initial performance
            if test_initial:
                print('test_initial')
                output_path_test_instance = os.path.join(output_path, f"{trial}", f"{-1}", "test")
                test_result_list = self.evaluate_tasks(output_path_test_instance, holdouttasks, system_test, saved_programs,
                                                       types_mapping=False, manual_abstractions=manual_abstractions)

                acc_test, times_test, solved_test, prog_length_test = read_results(test_result_list)
                all_accuracies[-1].append(acc_test)
                all_learning_times[-1].append(times_test)
                all_solved[-1].append(solved_test)
                all_prog_length[-1].append(prog_length_test)

            batch = 0
            steps = list(range(0, len(traintasks), stevie_every_n_tasks))
            if not steps:
                steps = [1]
            for k in steps:
                accuracies_train.append([])
                learning_times_train.append([])

                if not os.path.exists(os.path.join(output_path, f"{trial}", f"{batch}")):
                    os.makedirs(os.path.join(output_path, f"{trial}", f"{batch}"))

                learned_programs_file = os.path.join(output_path, f"{trial}", f"{batch}", "programs.pl")
                abstractions = os.path.join(output_path, f"{trial}", f"{batch}", "abstractions.pl")
                refactored_theory_file = os.path.join(output_path, f"{trial}", f"{batch}", "compressed_list_progs.pl")
                open(learned_programs_file, "w+").close()
                open(abstractions, "w+").close()
                open(refactored_theory_file, "w+").close()

                if batch > 0 or previously_learned:
                    previous_progs = []
                    if batch > 0:
                        with open(os.path.join(output_path, f"{trial}", f"{batch-1}", "programs.pl"), "r") as previous:
                            previous_progs += previous.readlines()
                    if previously_learned:
                        with open(PREVISOULY_LEARNED, "r") as progs:
                            previous_progs += progs.readlines()
                    with open(learned_programs_file, "w+") as current:
                        current.write("".join(previous_progs))

                print(f"tasks {k}/{len(traintasks)}")

                output_path_train_instance = os.path.join(output_path_trial, f"{batch}", "train")

                # TRAINING

                if self.stevie:
                    train_result_list = self.evaluate_tasks(output_path_train_instance, traintasks[k:k+stevie_every_n_tasks],
                                                            system_train, saved_programs, types_mapping=False,
                                                            manual_abstractions=manual_abstractions)

                    for r in train_result_list:
                        if r.solution:
                            with open(learned_programs_file, "a") as f:
                                f.write(r.solution)
                                f.write("\n")
                        accuracies_train[-1].append(r.accuracy)
                        learning_times_train[-1].append(r.total_exec_time)

                    logger.info(f"Results for {len(train_result_list)} instances written to {results_file}")

                    start = perf_counter()

                    ctx = mp.get_context('spawn')
                    manager = multiprocessing.Manager()
                    return_dict = manager.dict()
                    p = ctx.Process(target=perform_abstraction, args=(learned_programs_file, abstractions,
                                                                              refactored_theory_file, return_dict,
                                                                              penalize_variables))
                    p.start()
                    p.join()

                    end = perf_counter()
                    print(f"stevie time {end - start} {return_dict['stevie_time']}")
                    stevie_time = return_dict['stevie_time']

                    stevie_duration.append([stevie_time])
                    with open(refactored_theory_file, "a") as f:
                        f.write(f"\n stevie time {stevie_time}\n")

                    print(f"training accuracies {accuracies_train}")
                    print(f"training learning times {learning_times_train}")

            # TESTING
                if isinstance(system_test, Popper):
                    ho_types, ho_directions = get_types(DEFAULT_BIAS, refactored_theory_file, learned_programs_file)
                else:
                    ho_types, ho_directions = None, None
                with open(abstractions, "r") as f:
                    abstrac = f.readlines()
                    print(f"abstractions {abstrac}")

                output_path_test_instance = os.path.join(output_path_trial, f"{batch}", "test")
                test_result_list = self.evaluate_tasks(output_path_test_instance, holdouttasks,
                                                        system_test, saved_programs, abstractions=abstrac,
                                                        hotypes=ho_types, ho_directions=ho_directions,
                                                       types_mapping=False, manual_abstractions=manual_abstractions)


                acc_test, times_test, solved_test, prog_length_test = read_results(test_result_list)
                all_accuracies[-1].append(acc_test)
                all_learning_times[-1].append(times_test)
                all_solved[-1].append(solved_test)
                all_prog_length[-1].append(prog_length_test)

                all_stevie_duration.append(stevie_duration)
                batch += 1

            if transfer_problems:
                accuracies_transfer, learning_times_transfer, prog_length_transfer, solved_transfer = \
                    self.evaluate_transfer_problems(output_path, trial, batch, penalize_variables_transfer, system_test,
                                                transfer_problems, saved_programs, abstractions=True, manual_abstractions=manual_abstractions)


            logger = get_logger()
            logger.info(f"Accuracies {accuracies}")
            logger.info(f"Learning times {learning_times}")


        def my_flatten(my_list):
            return [num for sublist in my_list for num in sublist]

        print(f"all_accuracies {all_accuracies}")
        accuracies = list(map(my_flatten, list(zip(*all_accuracies))))
        all_learning_times = list(map(my_flatten, list(zip(*all_learning_times))))
        print(f"all_learning_times {all_learning_times}")
        all_stevie_duration = list(map(my_flatten, list(zip(*all_stevie_duration))))
        all_prog_length = list(map(my_flatten, list(zip(*all_prog_length))))
        all_solved = list(map(my_flatten, list(zip(*all_solved))))

        if all([len(sub_list) > 0 for sub_list in accuracies]):
            all_accuracies_average = [sum(sub_list) / len(sub_list) for sub_list in accuracies]
            all_learning_times_average = [sum(sub_list) / len(sub_list) for sub_list in all_learning_times]
            all_stevie_duration_average = [sum(sub_list) / len(sub_list) for sub_list in all_stevie_duration]
            all_prog_length_average = [sum(sub_list) / len(sub_list) if sub_list else 0 for sub_list in all_prog_length]
            all_solved_average = [sum(sub_list) / len(sub_list) if sub_list else 0 for sub_list in all_solved]

            def my_sem(values):
                if len(values) > 1:
                    return stats.sem(values)
                return 0

            all_accuracies_sem = [my_sem(sub_list) for sub_list in accuracies]
            all_learning_times_sem = [my_sem(sub_list) for sub_list in all_learning_times]
            all_stevie_duration_sem = [my_sem(sub_list) for sub_list in all_stevie_duration]
            all_prog_length_sem = [my_sem(sub_list) for sub_list in all_prog_length]
            all_solved_sem = [my_sem(sub_list) for sub_list in all_solved]

            print(f"accuracies {all_accuracies_average} += {all_accuracies_sem}")
            print(f"learning times {all_learning_times_average} += {all_learning_times_sem}")
            print(f"stevie {all_stevie_duration_average} += {all_stevie_duration_sem}")
            print(f"prog length {all_prog_length_average} += {all_prog_length_sem}")
            print(f"solved {all_solved_average} += {all_solved_sem}")

            with open(results_file, "a") as f:
                f.write(f"\n# accuracies\n")
                f.write('#' + str(all_accuracies_average))
                f.write('#' + str(all_accuracies_sem))
                f.write(f"\n# learning times\n")
                f.write('#' + str(all_learning_times_average))
                f.write('#' + str(all_learning_times_sem))
                f.write(f"\n# stevie\n")
                f.write('\nstevie_duration_average =' + str(all_stevie_duration_average))
                f.write('\nstevie_duration_sem =' + str(all_stevie_duration_sem))
                f.write(f"\n# prog length\n")
                f.write('#' + str(all_prog_length_average))
                f.write('#' + str(all_prog_length_sem))
                f.write(f"\n# solved\n")
                f.write('#' + str(all_solved_average))
                f.write('#' + str(all_solved_sem))

        if transfer_problems:
            with open(results_file, "a") as f:
                for p in accuracies_transfer.keys():
                    f.write(f"\n\n#TRANSFER {p}\n")
                    f.write("accuracies_transfer = " + "".join(str(accuracies_transfer[p]))+"\n")
                    f.write("learning_times_transfer = " + "".join(str(learning_times_transfer[p]))+"\n")
                    f.write("program_length_transfer = " + "".join(str(prog_length_transfer[p]))+"\n")
                    f.write("solved_transfer = " + "".join(str(solved_transfer[p]))+"\n")

    def run_tasks(self, ctx, tasks, output_path, saved_programs, num_threads):
        logger = get_logger()

        with ctx.Manager() as manager:
            sema = manager.BoundedSemaphore(num_threads)

            results_q = manager.Queue()
            all_processes = []
            unhandled_processes = []

            for instance in tasks:
                sema.acquire()

                new_unhandled_processes = []
                for process in unhandled_processes:
                    if process.exitcode is None:
                        new_unhandled_processes.append(process)
                    elif process.exitcode < 0:
                        logger.debug(f"{process.name} CRASHED. RELEASING")
                        sema.release()
                unhandled_processes = new_unhandled_processes

                p = ctx.Process(target=self.run_instance, args=(instance, sema, results_q,
                                                                saved_programs), name=instance.name)
                all_processes.append(p)
                unhandled_processes.append(p)
                p.start()

            for p in all_processes:
                p.join()

            result_list = queue_to_list(results_q)

            for result in result_list:
                logger.info(result)
                with open(f"{output_path}/{result.problem_name}/results.txt", "w+") as f:
                    if result.solution:
                        f.write(result.solution)
                    else:
                        f.write("% no solution")
                    f.write("\n")
                    f.write(f"% accuracy: {str(result.accuracy)}")
                    f.write("\n")
                    f.write(f"% learning time: {result.total_exec_time}")

        return result_list

    def run_instance(self, instance, sema, results_q, saved_programs="", depth=None, added_bk=""):
        logger = get_logger()
        now = datetime.now()
        current_time = now.strftime("%H:%M:%S")
        logger.info(f'\nRunning {instance.name} {current_time}')

        try:
            result = instance.run(added_bk, saved_programs, depth)
        except Exception as e:
            logger.info(f"Exception in instance {instance.name}")
            logger.info(traceback.format_exc())
            logger.error("Unexpected error:", sys.exc_info()[0])
            raise e

        logger.info(f'{instance.name} completed in {result.total_exec_time:0.3f}s')
        logger.info(result.solution)

        results_q.put(result, block=True)

        sema.release()

        return result


def make_bias_popper(abstractions, ho_types_dict, ho_directions_dict):
    bias, bk, predicates, calling_diagram = set(), [], [], defaultdict(list)
    if abstractions:
        for line in abstractions:
            if line and line != "\n":
                split = line.split(":-")
                if len(split) == 2:
                    head, _ = split
                    head = head.strip()
                    name, arity = get_predicate(head)
                    predicates.append([name, arity])
                    bias.add(tuple((name, arity)))
                    add_bk, preds_line = replace_pred_call(line.strip())
                    bk.append(add_bk+"\n")
                    calling_diagram[name].extend(preds_line)
                else:
                    bk.append(line)

        ho_bias = [f"body_pred({name},{arity},ho).\n" for (name, arity) in bias]
        ho_types = [f"type({name},{remove_quotes(type)}).\n" for name, type in ho_types_dict.items()]
        ho_dirs = [f"direction({name},{remove_quotes(dir)}).\n" for name, dir in ho_directions_dict.items()]
    else:
        ho_bias, ho_types, ho_dirs = [], [], []

    return ho_bias + ho_types + ho_dirs + ["\n"], "\n".join(bk) + "\n", calling_diagram


def get_predicate(atom):
    pred, args = pred_arguments(atom)
    pred = pred.strip()
    args = args.split(',')
    return pred, len(args)


def pred_arguments(atom):
    pred, arguments = atom.strip().replace(')', '').split('(')
    return pred, arguments


def replace_pred_call(line):
    line = line.strip('.')
    head, body = line.split(":-")
    preds_line = []
    head_atom = convert_to_atom(head)
    body = [x.strip() for x in body.split("),")]
    body = [convert_to_atom(b) for b in body]
    new_body = []
    for b in body:
        if b.predicate in head_atom.args:
            new_body.append(f"call({b.predicate},{','.join(b.args)})")
        else:
            new_body.append(str(b))
            if b.predicate != head_atom.predicate:
                preds_line.append(list([b.predicate, len(b.args)]))
    return f"{str(head)} :- {','.join(new_body)}.", preds_line


def remove_quotes(y):
    return str(y).replace("'", "")

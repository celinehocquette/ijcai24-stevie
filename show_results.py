import os
from collections import defaultdict
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import scipy.stats as stats


SYSTEMS = ['norefactoring', 'prolog', 'stevie', 'nopenalty']

TRIALS = ['0', '1', '2', '3', '4']

N_TASKS = [0, 30, 60, 90, 120, 132]

TIMEOUT = 900


TASKS = ['do5times', 'line1', 'line2', 'string7bis', 'string47', 'string226bis', 'string236',
         'chessmapuntil1', 'chessmapfilter1', 'chessmapfilteruntil1', 'chessoriginal', 'addN', 'alleven', 'allseqN',
         'depth', 'droplast', 'droplastk', 'dropk', 'encryption', 'finddup', 'firstHalf', 'isBranch', 'isPalindrome',
         'isSubTree', 'lastHalf', 'mylength', 'member', 'multFromSuc', 'of1And2', 'repeatN', 'reverse', 'rotateN', 'sorted',
         'waiter', 'waiter2']

SEPARATOR = ['line2', 'string236', 'chessoriginal', 'sorted']

def parse_rule(line):
    head, body = line.split(":-")
    b_lit = body.split("),")
    return len(b_lit)+1

def parse_results(file):
    with open(file, "r") as f:
        res = f.readlines()
        prog_size = 0
        for line in res:
            if "% accuracy:" in line:
                acc = float(line.split(":")[1])
            elif "% learning time:" in line:
                time = float(line.split(":")[1])
            elif line and not line.startswith("%"):
                prog_size += parse_rule(line)
    return acc, time, prog_size


def read_results(name, show_stevie=False):
    accuracies_test = defaultdict(list)
    time_test = defaultdict(list)
    prog_size_test = defaultdict(list)
    results_path = f"./results/{name}/"
    accuracies_transfer, time_transfer = [], []
    for t in TRIALS:
        for n_stevie in os.listdir(os.path.join(results_path, t)):
            if os.path.isdir(os.path.join(results_path, t, n_stevie)):

                if os.path.isdir(os.path.join(results_path, t, n_stevie, "test")):
                    for task in os.listdir(os.path.join(results_path, t, n_stevie, "test")):
                        if os.path.isdir(os.path.join(results_path, t, n_stevie, "test", task)):
                            acc, time, prog_size = parse_results(os.path.join(results_path, t, n_stevie, "test", task, "results.txt"))
                            accuracies_test[n_stevie].append(acc)
                            time_test[n_stevie].append(time)
                            if prog_size:
                                prog_size_test[n_stevie].append(prog_size)

        max_batch = str(max([int(n) for n in os.listdir(os.path.join(results_path, t)) if os.path.isdir(os.path.join(results_path, t, n))]))
        if "transfer" in os.listdir(os.path.join(results_path, t, max_batch)):
            for task in os.listdir(os.path.join(results_path, t, max_batch, "transfer")):
                if os.path.isdir(os.path.join(results_path, t, max_batch, "transfer", task)):
                    acc, time, prog_size = parse_results(os.path.join(results_path, t, max_batch, "transfer", task, "results.txt"))
                    accuracies_transfer.append(acc)
                    time_transfer.append(time)

    return accuracies_test, time_test, prog_size_test, accuracies_transfer, time_transfer


def data_stats(name, values, percentage=False):
    data = defaultdict(list)
    for k in sorted(values.keys()):
        av = np.mean(values[k])
        if percentage:
            av = av * 100
        sem = stats.sem(values[k]) if stats.sem(values[k]) == stats.sem(values[k]) else 0
        if percentage:
            sem = sem * 100
        data['xs'].append(N_TASKS[int(k)+1])
        data['av'].append(av)
        data['sem'].append(sem)

    data = pd.DataFrame.from_dict(data)
    results_path = f"./results/{name}/"
    pd.DataFrame(data).to_csv(os.path.join(results_path, f"results.csv"), index=False)
    return data


def plot_data(all_data, ylabel, xlabel='Number of tasks'):
    for name in all_data:
        plt.errorbar(all_data[name]['xs'], all_data[name]['av'], all_data[name]['sem'], label=name, elinewidth=1)
    plt.legend()
    plt.ylabel(ylabel, fontsize=18)
    plt.xlabel(xlabel, fontsize=18)
    plt.show()


def show_results_transfer(name):
    acc_initial, time_initial, prog_size_initial = defaultdict(list), defaultdict(list), defaultdict(list)
    acc_final, time_final, prog_size_final = defaultdict(list), defaultdict(list), defaultdict(list)

    results_path = f"./results/{name}/"

    tasks = set()
    for t in TRIALS:
        n_batches = [int(n) for n in os.listdir(os.path.join(results_path, t)) if os.path.isdir(os.path.join(results_path, t, n))]
        n_batch_min, n_batch_max = min(n_batches), max(n_batches)
        for task in os.listdir(os.path.join(results_path, str(t), str(n_batch_min), "transfer")):
            tasks.add(task)
            acc, time, prog_size = parse_results(os.path.join(results_path, str(t), str(n_batch_min), "transfer", task, "results.txt"))
            acc_initial[task].append(acc)
            time_initial[task].append(time)
            prog_size_initial[task].append(prog_size)
            acc, time, prog_size = parse_results(os.path.join(results_path, str(t), str(n_batch_max), "transfer", task, "results.txt"))
            acc_final[task].append(acc)
            time_final[task].append(time)
            prog_size_final[task].append(prog_size)

    print("accuracy")
    initial, final = [], []
    for t in TASKS:
        print(t)
        acc_initial_av = round(np.mean(acc_initial[t]) * 100)
        acc_initial_sem = round(stats.sem(acc_initial[t]) * 100) if stats.sem(acc_initial[t]) == \
                                                                    stats.sem(acc_initial[t]) else 0
        acc_final_av = round(np.mean(acc_final[t]) * 100)
        acc_final_sem = round(stats.sem(acc_final[t]) * 100) if stats.sem(acc_initial[t]) == \
                                                                stats.sem(acc_initial[t]) else 0
        initial.extend(acc_initial[t])
        final.extend(acc_final[t])
        if acc_initial_av < acc_final_av:
            print(f"\emph{{{t}}} & {acc_initial_av} $\pm$ {acc_initial_sem} & \\textbf{{{acc_final_av} $\pm$ {acc_final_sem}}}\\\\")

        elif acc_initial_av > acc_final_av:
            print(f"\emph{{{t}}} & \\textbf{{{acc_initial_av} $\pm$ {acc_initial_sem}}} & {acc_final_av} $\pm$ {acc_final_sem}\\\\")
        else:
            print(f"\emph{{{t}}} & \\textbf{{{acc_initial_av} $\pm$ {acc_initial_sem}}} & \\textbf{{{acc_final_av} $\pm$ {acc_final_sem}}}\\\\")

        if t in SEPARATOR:
            print("\midrule")

    initial_av = round(np.mean(initial)*100)
    initial_sem = round(stats.sem(initial)*100) if stats.sem(initial) == stats.sem(initial) else 0
    final_av = round(np.mean(final)*100)
    final_sem = round(stats.sem(final)*100) if stats.sem(final) == stats.sem(final) else 0

    if initial_av > final_av:
        print(f"\emph{{average}} & \\textbf{{{initial_av} $\pm$ {initial_sem}}} & {final_av} $\pm$ {final_sem}\\\\")
    elif initial_av < final_av:
        print(f"\emph{{average}} & {initial_av} $\pm$ {initial_sem} & \\textbf{{{final_av} $\pm$ {final_sem}}}\\\\")
    else:
        print(f"\emph{{average}} & \\textbf{{{initial_av} $\pm$ {initial_sem}}} & \\textbf{{{final_av} $\pm$ {final_sem}}}\\\\")

    print("\n\ntime")
    initial, final = [], []
    for t in TASKS:
        time_initial_av = round(np.mean(time_initial[t]))
        time_initial_sem = round(stats.sem(time_initial[t])) if stats.sem(time_initial[t]) == \
                                                                stats.sem(time_initial[t]) else 0
        time_final_av = round(np.mean(time_final[t]))
        time_final_sem = round(stats.sem(time_final[t])) if stats.sem(time_initial[t]) == \
                                                            stats.sem(time_initial[t]) else 0
        initial.extend(time_initial[t])
        final.extend(time_final[t])
        if time_initial_av >= TIMEOUT and time_final_av >= TIMEOUT:
            print(f"\emph{{{t}}} & \emph{{timeout}} & \emph{{timeout}}\\\\")
        elif time_final_av >= TIMEOUT:
            print(f"\emph{{{t}}} & \\textbf{{{time_initial_av} $\pm$ {time_initial_sem}}} & \emph{{timeout}}\\\\")
        elif time_initial_av >= TIMEOUT:
            print(f"\emph{{{t}}} & \emph{{timeout}} & \\textbf{{{time_final_av} $\pm$ {time_final_sem}}}\\\\")
        elif time_initial_av < time_final_av:
            print(f"\emph{{{t}}} & \\textbf{{{time_initial_av} $\pm$ {time_initial_sem}}} & {time_final_av} $\pm$ {time_final_sem}\\\\")
        elif time_initial_av > time_final_av:
            print(f"\emph{{{t}}} & {time_initial_av} $\pm$ {time_initial_sem} & \\textbf{{{time_final_av} $\pm$ {time_final_sem}}}\\\\")
        else:
            print(f"\emph{{{t}}} & \\textbf{{{time_initial_av} $\pm$ {time_initial_sem}}} & \\textbf{{{time_final_av} $\pm$ {time_final_sem}}}\\\\")

        if t in SEPARATOR:
            print("\midrule")
    initial_av = round(np.mean(initial))
    initial_sem = round(stats.sem(initial)) if stats.sem(initial) == stats.sem(initial) else 0
    final_av = round(np.mean(final))
    final_sem = round(stats.sem(final)) if stats.sem(final) == stats.sem(final) else 0

    if initial_av < final_av:
        print(f"\emph{{average}} & \\textbf{{{initial_av} $\pm$ {initial_sem}}} & {final_av} $\pm$ {final_sem}\\\\")
    elif initial_av > final_av:
        print(f"\emph{{average}} & {initial_av} $\pm$ {initial_sem} & \\textbf{{{final_av} $\pm$ {final_sem}}}\\\\")
    else:
        print(f"\emph{{average}} & \\textbf{{{initial_av} $\pm$ {initial_sem}}} & \\textbf{{{final_av} $\pm$ {final_sem}}}\\\\")

if __name__ == '__main__':

    aggr_acc_test = defaultdict(list)
    aggr_time_test = defaultdict(list)
    aggr_prog_size_test = defaultdict(list)
    for name in SYSTEMS:
        accuracies_test, time_test, prog_size_test, accuracies_transfer, time_transfer = read_results(name, name=='stevie')

        aggr_acc_test[name] = data_stats(name, accuracies_test, percentage=True)
        aggr_time_test[name] = data_stats(name, time_test, percentage=False)
        aggr_prog_size_test[name] = data_stats(name, prog_size_test, percentage=False)

        if name == 'stevie':
            acc_transfer_av = round(np.mean(accuracies_transfer) * 100)
            acc_transfer_sem = round(stats.sem(accuracies_transfer) * 100) if stats.sem(accuracies_transfer) == \
                                                                            stats.sem(accuracies_transfer) else 0

            time_transfer_av = round(np.mean(time_transfer))
            time_transfer_sem = round(stats.sem(time_transfer)) if stats.sem(time_transfer) == stats.sem(time_transfer) else 0

            print(f"transfer acc av {acc_transfer_av} $\pm$ {acc_transfer_sem}")
            print(f"transfer time av {time_transfer_av} $\pm$ {time_transfer_sem}")

            show_results_transfer(name)

    plot_data(aggr_acc_test, ylabel='Testing accuracy')
    plot_data(aggr_time_test, ylabel='Testing time')
    plot_data(aggr_prog_size_test, ylabel='Program size')

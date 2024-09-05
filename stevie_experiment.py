from ilpexperiments.ilpexp.runner import MultiTaskStevie
from ilpexperiments.ilpexp.experiment import LIST_PROBLEMS
from ilpexperiments.ilpexp.experiment import POPPER_HO
from ilpexperiments.ilpexp.problem import WaiterProblem, WaiterProblem2
from ilpexperiments.ilpexp.problem.listHigherOrder import DEFAULT_LIST_HO_PROBLEMS
from ilpexperiments.ilpexp.problem import STRING_TRANSFER, ASCII_TRANSFER, CHESS_TRANSFER

N_RUNS = 1

NO_REFACTORING = False
PROLOG = False

stevie_every_n_tasks = 30

if __name__ == '__main__':

    TRANSFER_PROBLEMS = STRING_TRANSFER + CHESS_TRANSFER + ASCII_TRANSFER + [WaiterProblem(), WaiterProblem2()] + DEFAULT_LIST_HO_PROBLEMS
    penalize_variables = 1
    penalize_variables_transfer = 1
    if NO_REFACTORING or PROLOG:
        STEVIE = False
    else:
        STEVIE = True
    if PROLOG:
        PROLOG_ABSTRACTIONS = True
    else:
        PROLOG_ABSTRACTIONS = False

    N_THREADS = 1

    runner = MultiTaskStevie(num_threads_train=N_THREADS, num_threads_test=N_THREADS, stevie=STEVIE)
    runner.run(N_RUNS, LIST_PROBLEMS, POPPER_HO, POPPER_HO, stevie_every_n_tasks, test_problems=[],
    manual_abstractions=PROLOG_ABSTRACTIONS, penalize_variables=penalize_variables, penalize_variables_transfer=penalize_variables_transfer,
               previously_learned=False, test_initial=True, transfer_problems=TRANSFER_PROBLEMS, initial_transfer=False)

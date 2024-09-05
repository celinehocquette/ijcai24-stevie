
from .problem import LIST_PROBLEMS
from .system import BASIC_POPPER, Popper

DEFAULT_OUTPUT_PATH='./results'

POPPER_HO = Popper("./hopper", {"--stats":"", "--debug":""}, timeout=900)
FUNCTIONAL_POPPER_HO = Popper("./hopper", {"--stats":"", "--functional-test": ""},
                              timeout=900)


class Experiment:
    def __init__(self, problems=LIST_PROBLEMS, systems=[BASIC_POPPER], output_path=DEFAULT_OUTPUT_PATH, trials=1):
        self.output_path = output_path
        self.problems = problems
        self.systems = systems

        if isinstance(trials, int):
            if trials == None:
                self.trials = [None]
            else:
                self.trials = range(trials)
        elif isinstance(trials, list):
            self.trials = trials
        else:
            raise(Exception(f"Unexpected data type given for Experiment parameter trials: {trials}"))

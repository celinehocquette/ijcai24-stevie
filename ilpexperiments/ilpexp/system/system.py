import tempfile

from ..util import curr_dir_relative, call_prolog
from ..result import ExperimentResult

class System:
    def __init__(self, name, id):
        self.name = name
        self.id = id

    def run(self, train_settings, test_settings, added_bk=None, saved_solutions=None, depth=None):

        (solution, total_exec_time, extra_stats) = self.train(train_settings, added_bk=None, depth=depth)

        conf_matrix = self.test(solution, test_settings, saved_solutions) if solution else None

        return (solution, total_exec_time, conf_matrix, extra_stats)
    
    def train(self, train_settings):
        pass

    def test(self, solution, test_settings, saved_solutions=None):
        if test_settings.metric == 'percentage_task_solved':
            return 1.0 if solution else 0.0

        if not solution:
            return None

        if saved_solutions:
            with open(saved_solutions, 'a+') as all_solution:
                all_solution.write(solution)
                all_solution.write("\n")
            
        with tempfile.NamedTemporaryFile() as solution_file:
            with open(solution_file.name, 'w') as f:
                f.write(solution)
                f.flush()

            test_file = curr_dir_relative('test.pl')

            files_to_load = [test_file, test_settings.exs_file, test_settings.bk_file, solution_file.name]
            
            action = 'print_conf_matrix.'
            
            result = call_prolog(action, files_to_load=files_to_load, timeout=600)

        return [int(n) for n in result.split(',')] if result else []

class BasicTestSettings:
    def __init__(self, exs_file, bk_file, metric='accuracy'):
        self.exs_file = exs_file
        self.bk_file = bk_file
        self.metric = metric

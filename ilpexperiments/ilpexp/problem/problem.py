from ..result import ExperimentResult
import os


def instance_name(problem, system, trial=None, parameter=None):
    trial_string = f"__{trial}" if trial else ""
    parameter_string = f"__{parameter}" if parameter else ""
    return f"{problem.name}__{system.id}{trial_string}{parameter_string}"


def instance_path(base_path, problem, system, trial=None, parameter=None):
    path_elements = [base_path, problem.name, system.id]
    if trial is not None:
        path_elements.append(str(trial))
    if parameter is not None:
        path_elements.append(str(parameter))
    return os.sep.join(path_elements)


class Problem:
    def __init__(self, name):
        self.name = name

    # This should be overridden by all subclasses.
    def generate_instances(self, system, output_path, trial, ):
        pass


class ProblemInstance:
    def __init__(self,
                 problem,
                 system,
                 train_settings,
                 test_settings,
                 trial=None,
                 saved_programs=None,
                 parameter=None):
        self.problem = problem
        self.system = system
        self.train_settings = train_settings
        self.test_settings = test_settings
        self.trial = trial
        self.saved_programs = saved_programs
        self.parameter = parameter

    def hash(self):
        return hash(f'{self.problem}'+f'{self.system}'+f'{self.trial}')

    @property
    def name(self):
        return instance_name(self.problem, self.system, self.trial, self.parameter)

    def output_dir(self, base_path):
        return instance_path(base_path, self.problem, self.system, self.trial, self.parameter)

    def run(self, added_bk=None, saved_programs=None, depth=None):
        (program, total_exec_time, conf_matrix, extra_stats) = self.system.run(self.train_settings, self.test_settings,
                                                                               added_bk, saved_programs, depth)
        return ExperimentResult(
            problem_name=self.problem.name,
            system_name=self.system.name,
            trial=self.trial,
            solution=program,
            total_exec_time=total_exec_time,
            conf_matrix=conf_matrix,
            extra_stats=extra_stats,
            parameter=self.parameter)

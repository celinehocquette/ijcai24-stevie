import sys
import os

import time

from stevie.loreleai.language.lp import ClausalTheory
from stevie.loreleai.learning.restructuring import Stevie
from time import perf_counter


DEFAULT_STEVIE_TIMEOUT = 3600

def perform_abstraction(theory_file: str, abstraction: str, restructured: str, return_dict, penalize_variables=True, max_time_s=DEFAULT_STEVIE_TIMEOUT):
    start = perf_counter()
    theory = ClausalTheory(read_from_file=theory_file, preserve_definitions=True)
    stevie = Stevie(theory)
    abstractions, th = stevie.abstract(max_higher_order_vars=3, penalize_variables=penalize_variables, max_time_s=max_time_s)
    for cl in th.get_formulas():
        print(cl)

    with open(restructured, "w+") as f:
        for cl in th.get_formulas():
            f.write(str(cl)+"\n")

    with open(abstraction, "w+") as f:
        for a in set(abstractions.values()):
            f.write(str(a)+"\n")
            
    end = perf_counter()
    return_dict['stevie_time'] = end - start

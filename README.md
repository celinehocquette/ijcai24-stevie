
This repository contains the experimental code and data for the paper: [Learning Logic Programs by Discovering Higher-Order Abstractions](https://arxiv.org/pdf/2308.08334), Céline Hocquette, Sebastijan Dumančić, and Andrew Cropper, accepted at IJCAI24.

# Requirements

[SWI-Prolog](https://www.swi-prolog.org)

[Clingo 5.5.0](https://potassco.org/clingo/)

[pyswip](https://pypi.org/project/pyswip/)

[ortools](https://developers.google.com/optimization)

[minikanren]

# Experimental results

The results are in the folder /results/{condition}/results/{run_id}.
- The training tasks (examples, bias, bk, and induced programs) are in the folder  /results/{condition}/results/{run_id}/{batch}/train/{task_name}
- The testing tasks (examples, bias, bk, and induced programs) are in the folder  /results/{condition}/results/{run_id}/{batch}/test/{task_name}

# Usage

Hopper is in the folder hopper.

You can reproduce the plots with the command: `python show_results.py`

You can run the learning / training again with the command: `python stevie_experiment.py`. It will generate new training and testing tasks.

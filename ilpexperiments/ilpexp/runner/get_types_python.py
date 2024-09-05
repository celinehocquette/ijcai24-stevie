
class Atom:
    def __init__(self, predicate, arity, args, negated=False):
        assert arity == len(args)
        self.predicate = predicate
        self.arity = arity
        self.args = args
        self.negated = negated

    def __str__(self):
        if self.negated:
            return f"not({self.predicate}({','.join(self.args)}))"
        return f"{self.predicate}({','.join(self.args)})"

def convert_to_atom(string):
    if string.startswith("not"):
        is_negated = True
        string = string.replace("not(", "")[:-1]
    else:
        is_negated = False
    pred, args = string.strip().replace(')', '').split('(')
    pred = pred.strip()
    args = args.split(',')
    return Atom(pred, len(args), args, negated=is_negated)


def get_types(files_types, compressed_prog, initial_progs):
    primitives_types = dict()
    primitives_directions = dict()
    primitives_arities = dict()
    with open(files_types) as f:
        while True:
            line = f.readline()
            if not line:
                break
            if len(line.split("(")) > 1 and line.split("(")[0] == "type":
                predicate = line.split("(")[1].split(",")[0]
                types = line.split("(")[2].split("))")[0].split(",")
                types = [t.replace(' ', '') for t in types]
                primitives_types[predicate] = types
            elif len(line.split("(")) > 1 and line.split("(")[0] == "direction":
                predicate = line.split("(")[1].split(",")[0]
                direction = line.split("(")[2].split("))")[0].split(",")
                primitives_directions[predicate] = direction

    ho_types, ho_directions = dict(), dict()
    add_new = True
    while add_new:
        add_new = False
        with open(initial_progs) as f:
            while True:
                line = f.readline()
                if not line:
                    break
                if ":-" in line:
                    var_types = dict()
                    head, body = line.split(":-")
                    head, body = head.strip(), body.strip().strip('.')
                    body = [x.strip() + ")" for x in body.split("),")]
                    head, body = convert_to_atom(head), [convert_to_atom(x) for x in body]
                    primitives_arities[head.predicate] = len(head.args)
                    if head.predicate in primitives_types:
                        for var, var_type in zip(head.args, primitives_types[head.predicate]):
                            var_types[var] = var_type
                    for atom in body:
                        primitives_arities[atom.predicate] = len(atom.args)
                        if atom.predicate in primitives_types:
                            for var, var_type in zip(atom.args, primitives_types[atom.predicate]):
                                var_types[var] = var_type

                    if head.predicate not in primitives_types and all([var in var_types for var in head.args]):
                        primitives_types[head.predicate] = [var_types[var] for var in head.args]
                        add_new = True
                    for b in body:
                        if b.predicate not in primitives_types and all([var in var_types for var in b.args]):
                            primitives_types[b.predicate] = [var_types[var] for var in b.args]
                            add_new = True
                    if head.predicate not in primitives_directions:
                        dirs = ['in' for _ in range(primitives_arities[head.predicate])]
                        for k, var in enumerate(head.args):
                            seen = set()
                            for body_atom in body:
                                for i, var_b in enumerate(body_atom.args):
                                    if var == var_b and var_b not in seen and body_atom.predicate in primitives_directions and \
                                            primitives_directions[body_atom.predicate][i] == "out":
                                        # print(f'out because {primitives_directions}')
                                        dirs[k] = "out"
                                    seen.add(var_b)
                        primitives_directions[head.predicate] = tuple(dirs)

    with open(compressed_prog) as f:
        while True:
            line = f.readline()
            if not line:
                break
            if ":-" in line:
                var_types = dict()
                head, body = line.split(":-")
                head, body = head.strip(), body.strip().strip('.')
                body = [x.strip() + ")" for x in body.split("),")]
                head, body = convert_to_atom(head), [convert_to_atom(x) for x in body]
                if not head.predicate.startswith('ho'):
                    if head.predicate in primitives_types:
                        for var, var_type in zip(head.args, primitives_types[head.predicate]):
                            var_types[var] = var_type
                    for atom in body:
                        if atom.predicate in primitives_types:
                            for var, var_type in zip(atom.args, primitives_types[atom.predicate]):
                                var_types[var] = var_type
                    for body_atom in body:
                        if body_atom.predicate.startswith('ho'):
                            primitives_arities[body_atom.predicate] = len(body_atom.args)
                            ho_var_types = [None for _ in range(primitives_arities[body_atom.predicate])]
                            for i, var in enumerate(body_atom.args):
                                if var.islower():
                                    if var in primitives_types:
                                        ho_var_types[i] = tuple(primitives_types[var])
                                else:
                                    if var in var_types:
                                        ho_var_types[i] = var_types[var]
                            if body_atom.predicate in ho_types:
                                for i in range(primitives_arities[body_atom.predicate]):
                                    if ho_types[body_atom.predicate][i] == None:
                                        ho_types[body_atom.predicate][i] = ho_var_types[i]
                                    elif ho_var_types[i] != None:
                                        assert ho_types[body_atom.predicate][i] == ho_var_types[i]
                            else:
                                ho_types[body_atom.predicate] = ho_var_types
                    for i, body_atom in enumerate(body):
                        if body_atom.predicate.startswith('ho'):
                            if body_atom.predicate not in ho_directions:
                                ho_directions[body_atom.predicate] = ["in" for _ in range(len(body_atom.args))]
                            dirs = dict()
                            if head.predicate in primitives_directions:
                                for i, v in enumerate(head.args):
                                    dirs[v] = primitives_directions[head.predicate][i]
                            for b in body[:i]:
                                if b.predicate in primitives_directions:
                                    for i, v in enumerate(b.args):
                                        if not v in dirs or dirs[v] == 'in':
                                            dirs[v] = primitives_directions[b.predicate][i]
                            for i, v in enumerate(body_atom.args):
                                if not v.islower():
                                    if v in dirs and (dirs[v] == 'out' or not ho_directions[body_atom.predicate][i]):
                                        ho_directions[body_atom.predicate][i] = dirs[v]
                                else:
                                    if v in primitives_directions:
                                        ho_directions[body_atom.predicate][i] = tuple(primitives_directions[v])
                else:
                    if head.predicate not in ho_directions:
                        ho_directions[head.predicate] = ["in" for _ in range(len(head.args))]
                    for k, var in enumerate(head.args):
                        seen = set()
                        for body_atom in body:
                            for i, var_b in enumerate(body_atom.args):
                                if var == var_b and var_b not in seen and body_atom.predicate in primitives_directions and\
                                        primitives_directions[body_atom.predicate][i] == "out":
                                    ho_directions[head.predicate][k] = "out"
                                seen.add(var_b)
    ho_types = {k: tuple(v) for k, v in ho_types.items()}
    ho_directions = {k: tuple(v) for k, v in ho_directions.items()}
    return ho_types, ho_directions

def remove_quotes(y):
    return str(y).replace("'", "")


from .core import Literal

class Rewriter:
    def __init__(self, higher_order_preds):
        self.higher_order_preds = set(pred_name for (pred_name, _arity) in higher_order_preds)

    def rewrite(self, program, directions):
        if self.needs_higher_order_rewrite(program):
            program, directions = self.higher_order_rewrite(program, directions)
        return program, directions

    def needs_higher_order_rewrite(self, program):
        return any('__' in lit.predicate and \
                   lit.predicate.split('__')[0] in self.higher_order_preds \
                   for _head, body in program \
                   for lit in body)

    def higher_order_rewrite(self, program, directions):
        def rewrite_literal(lit):
            ho_pred_name = lit.predicate.split('___')[0]
            ho_encoded_args = lit.predicate.split('___')[1:]
            ho_args = ((int(pos_pred_name[0]), pos_pred_name[1:]) \
                       for pos_pred_name in ho_encoded_args)
            fo_args = iter(lit.arguments)
            lit_dir = iter(lit.directions)
            new_args = []
            directions = []
            fo_arg = next(fo_args, None)
            ho_arg = next(ho_args, None)
            dir = next(lit_dir, None)
            for arg_pos in range(len(lit.arguments) + len(ho_encoded_args)):
                if ho_arg is not None and ho_arg[0] == arg_pos:
                    new_args.append(ho_arg[1])
                    ho_arg = next(ho_args, None)
                    directions.append("ho")
                else:
                    assert fo_arg is not None
                    new_args.append(fo_arg)
                    fo_arg = next(fo_args, None)
                    directions.append(dir)
                    dir = next(lit_dir, None)
            return Literal(ho_pred_name, tuple(new_args), directions) # NB: doesn't copy over other attributes of lit

        rewritten_clauses = []
        for clause in program:
            head, body = clause
            def lits():
                for lit in body:
                    if '__' in lit.predicate and \
                            lit.predicate.split('__')[0] in self.higher_order_preds:
                        new_lit = rewrite_literal(lit)
                        directions[new_lit.predicate] = new_lit.directions
                        yield new_lit
                    else:
                        yield lit

            rewritten_clauses.append((head, tuple(lits())))

        return tuple(rewritten_clauses), directions

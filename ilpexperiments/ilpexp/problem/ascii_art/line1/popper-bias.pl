max_vars(4).
max_body(4).
max_clauses(2).
max_ho(1).
enable_recursion.

% line1(A,B):- ho_197(A,B,inv_ho_0,at_right).
% inv_ho_0(A,B):- draw0(A,C),move_right(C,B).


head_pred(line1,2).
type(line1,(state, state)).
direction(line1,(in,out)).



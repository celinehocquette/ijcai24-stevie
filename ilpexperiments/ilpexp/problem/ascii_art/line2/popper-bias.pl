head_pred(line2,2).
type(line2,(state, state)).
direction(line2,(in,out)).


% line2(A,B):- until(A,C,inv_until_1_1,at_bottom), draw1(C,B).
% inv_until_1_1(A,B):- move_down(A,C), move_right(C,D), draw1(D,B).

max_vars(4).
max_body(3).
max_clauses(2).
max_ho(1).
enable_recursion.
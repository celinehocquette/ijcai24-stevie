
%f(A,B,C):-empty(D),ite_a(D,B,C,A).
%ite_p_a(A,B,C):-app(A,C,B).

head_pred(f,3).
type(f,(list,element,list)).
direction(f,(in,in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(append,3).
type(append,(list,list,list)).
direction(append,(in,in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.
max_ho(1).

% repeatN(A,B,C):- empty(D), iterate(A,B,D,C,append).
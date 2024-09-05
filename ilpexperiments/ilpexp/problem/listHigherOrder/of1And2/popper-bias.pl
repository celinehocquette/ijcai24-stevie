
%f(A):-empty(A).
%try_q_a(A):-zero(B),suc(B,C),suc(C,A).
%f(A):-cons(A,C,B),try_a(C),f(B).
%try_p_a(A):-zero(B),suc(B,A).

head_pred(f,1).
type(f,(list,)).
direction(f,(in,)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(cons,3).
type(cons,(list,element,list)).
direction(cons,(in,out,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

max_vars(5).
max_body(5).
max_clauses(4).
max_ho(1).
enable_recursion.
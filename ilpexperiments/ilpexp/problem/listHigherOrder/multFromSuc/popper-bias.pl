
%ite_p_a(A,B,C):-ite_a(A,C,B).
%f(A,B,C):-zero(D),ite_a(D,A,C,B).
%ite_p_a(A,B):-suc(A,B).

head_pred(f,3).
type(f,(element,element,element)).
direction(f,(in,in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(out,in)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(decrement, 2).
type(decrement,(element,element)).
direction(pred,(in,out)).

body_pred(eq, 2).
type(eq,(element,element)).
direction(eq,(in,out)).

body_pred(less0, 1).
type(less0,(element,)).
direction(less0,(in,)).

max_clauses(3).
max_vars(5).
max_body(5).
enable_recursion.
max_ho(1).
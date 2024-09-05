
%f(A,B,C):-ite_a(B,A,C).
%ite_p_a(A,B):-tail(A,B).

head_pred(dropk,3).
type(dropk,(element,list,list)).
direction(dropk,(in,in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(eq_list,2).
type(eq_list,(list,list)).
direction(eq_list,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

max_vars(5).
max_clauses(2).
max_body(5).
max_ho(1).
enable_recursion.


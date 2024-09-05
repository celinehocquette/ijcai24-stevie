
%f(A,B,C):-eqs(C,B),z(A).
%f(A,B,C):-pred(A,E),map(map_p_a,B,D),f(E,D,C).
%map_p_a(A,B):-reverse(A,D),tail(D,C),reverse(C,B).

head_pred(droplastk,3).
type(droplastk,(element,list,list)).
direction(droplastk,(in,in,out)).

enable_recursion.

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(append,3).
type(append,(list,list,list)).
direction(append,(in,in,out)).

body_pred(eq_list,2).
type(eq_list,(list,list)).
direction(eq_list,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(reverse,2).
type(reverse,(list,list)).
direction(reverse,(in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

max_vars(5).
max_clauses(3).
max_body(5).
enable_recursion.
max_ho(1).
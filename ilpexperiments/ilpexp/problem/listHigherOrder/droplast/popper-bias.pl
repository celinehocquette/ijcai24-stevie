
%f(A,B):-map(map_p_a,A,B).
%map_p_a(A,B):-reverse(A,C),tail(C,D),reverse(D,B).

head_pred(droplast,2).
type(droplast,(list,list)).
direction(droplast,(in,in)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(reverse,2).
type(reverse,(list,list)).
direction(reverse,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(cons3,3).
type(cons3,(list,element,list)).
direction(cons3,(in,out,out)).

max_vars(5).
max_body(5).
max_clauses(3).
max_ho(1).
enable_recursion.


% dropLast(A, B):- map(A, B, p).
% p(A, B):- reverse(A, C), tail(C, D), reverse(D, B).

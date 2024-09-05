% caselist_r_a(A,B,C):-front(B,E),caselist_a(E,D),app(D,A,C).
% caselist_p_a(A):-empty(A).
% f(A,B):-reverse(A,C),caselist_a(C,B).
% caselist_q_a(A,B):-any(A),empty(B).

head_pred(f,2).
type(f,(list,list)).
direction(f,(in,out)).

body_pred(front,2).
type(front,(list,list)).
direction(front,(in,out)).

body_pred(cons1,3).
type(cons1,(list,element,list)).
direction(cons1,(in,in,out)).

body_pred(reverse,2).
type(reverse,(list,list)).
direction(reverse,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(any,1).
type(any,(element,)).
direction(any,(in,)).

max_vars(5).
max_body(5).
max_clauses(4).
enable_recursion.
max_ho(1).




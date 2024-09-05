%condlist_p_a(A,B):-any(A),empty(B).
%condlist_p_a(A,B):-last(B,A),front(B,C),condlist_a(C).
%f(A):-condlist_a(A).

head_pred(f,1).
type(f,(list,)).
direction(f,(in,)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(front,2).
type(front,(list,list)).
direction(front,(in,out)).

body_pred(last,2).
type(last,(list,element)).
direction(last,(in,out)).

body_pred(any, 1).
type(any,(element,)).
direction(any,(in,)).

max_vars(5).
max_clauses(3).
max_body(5).
enable_recursion.

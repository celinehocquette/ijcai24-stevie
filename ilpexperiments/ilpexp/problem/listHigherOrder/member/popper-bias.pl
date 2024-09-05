
%any_p_a(A,B):-head(A,B).
%f(A,B):-any_a(A,B).

head_pred(member,2).
type(member,(list,element)).
direction(member,(in,in)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.
max_ho(1).
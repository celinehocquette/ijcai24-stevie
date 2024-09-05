
%casetree_p_a(A,B):-tail(B,C),empty(C),head(B,A).
%any_p_a(A,B):-tail(B,C),casetree_a(A,C).
%casetree_q_a(A,B,C):-head(C,A),any_a(B,C).
%f(A,B):-casetree_a(A,B).

head_pred(f,2).
type(f,(tree,list)).
direction(f,(in,in)).

body_pred(children,2).
type(children,(tree,list)).
direction(children,(in,out)).

body_pred(root,2).
type(root,(tree,element)).
direction(root,(in,out)).


body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

max_vars(5).
max_clauses(4).
max_body(5).

% switches enabled
enable_recursion.


%f(A,B):-eqs(A,B).
%f(A,B):-children(A,C),any_a(C,B).
%any_p_a(A,B):-f(A,B).

head_pred(f,2).
type(f,(tree,tree)).
direction(f,(in,in)).

body_pred(eq,2).
type(eq,(tree,tree)).
direction(eq,(in,out)).

body_pred(children,2).
type(children,(tree,list)).
direction(children,(in,out)).

body_pred(root,2).
type(root,(tree,element)).
direction(root,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,tree)).
direction(head,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).


max_vars(5).
max_body(5).
max_clauses(2).
max_ho(1).
enable_recursion.


% f(A,B) :- eq(A,B).
% f(A,B) :- children(A,C), ho_374(C,B,f).
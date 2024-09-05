
%caselist_q_a(A,B,C):-caselist_a(B,C).
%caselist_q_a(A,B,C):-member(C,B),eq(C,A).
%caselist_p_a(A):-empty(B),member(A,B).
%f(A,B):-caselist_a(A,B).

head_pred(finddup,2).
type(finddup,(list, element)).
direction(finddup,(in,out)).

body_pred(member,2).
type(member,(element,list)).
direction(member,(out,in)).

body_pred(head,2).
type(head,(list,tree)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(eq,2).
type(eq,(element,element)).
direction(eq,(out,in)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

max_vars(5).
max_clauses(4).
max_body(5).
enable_recursion.
non_datalog.
allow_singletons.
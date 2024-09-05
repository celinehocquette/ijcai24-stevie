
%% f(A,B) :- empty(A),zero(B).
%% f(A,B) :- tail(A,D),f(D,C),succ(C,B).

head_pred(mylength,2).
type(mylength,(list,element)).
direction(mylength,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(one,1).
type(one,(element,)).
direction(one,(out,)).

max_vars(5).
max_body(5).
max_clauses(2).
non_datalog.
allow_singletons.
enable_recursion.
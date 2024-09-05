
%ite_p_a(A,B):-suc(A,B).
%f(A,B):-zero(C),ite_a(C,A,D),map_a(D,B).
%map_p_a(A,B):-zero(C),ite_a(C,A,B).

% allSeqN(A,B) :- zero(C), iterate(C,A,D,succ), map(D,B,f1).
% f1(A,B) :- zero(C), iterate(C,A, B,succ).

head_pred(f,2).
type(f,(element,list)).
direction(f,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(less0,1).
type(less0,(element,)).
direction(less0,(in,)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

max_vars(5).
max_clauses(2).
max_body(5).
max_ho(3).
enable_recursion.


%h(A, B, C):- zero(A), empty(C).
%h(A, B, C):- decrement(A, D), increment(B, E), h(D,E,F),tail(C,F), head(C, E).

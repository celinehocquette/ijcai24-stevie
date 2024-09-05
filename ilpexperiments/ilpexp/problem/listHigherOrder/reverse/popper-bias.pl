head_pred(myreverse,2).
type(myreverse,(list, list)).
direction(myreverse,(in,out)).


% reverse(A,B) :- empty(A), empty(B).
% reverse(A,B) :- head(A,C), tail(A,D), reverse(D,E), cons3(E,C,B).

% reverse(A,B) :- fold(A,B,empty, cons3).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(in,)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

%% TODO: remove cons3 and use head and tail: need to change directions in the abstraction
body_pred(cons3,3).
type(cons3,(list,element,list)).
direction(cons3,(in,in,out)).


max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.
max_ho(1).
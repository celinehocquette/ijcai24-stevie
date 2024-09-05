head_pred(addfour,2).
type(addfour,(list, list)).
direction(addfour,(in, in)).

%% addthree(A,B) :- empty(A), empty(B).
%% addthree(A,B) :- head(A,C), my_succ(C,G), my_succ(G,H), my_succ(H,D), tail(A,E), addone(E,F), cons(D,F,B).

max_body(4).
max_vars(5).
max_ho(1).
enable_recursion.

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).



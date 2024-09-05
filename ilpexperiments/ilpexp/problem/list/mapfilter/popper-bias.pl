
%% addone(A,B) :- empty(A), empty(B).
%% addone(A,B) :- head(A,C), my_succ(C,D), tail(A,E), addone(E,F), cons(D,F,B).

max_body(5).
max_vars(5).

enable_recursion.

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).


body_pred(triple,2).
type(triple,(element,element)).
direction(triple,(in,out)).

body_pred(square,2).
type(square,(element,element)).
direction(square,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(negative,1).
type(negative,(element,)).
direction(negative,(in,)).

body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).

:- body_literal(0,head,_,_).
:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

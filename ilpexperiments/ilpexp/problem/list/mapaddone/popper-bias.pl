head_pred(mapaddone,2).
type(mapaddone,(list, list)).
direction(mapaddone,(in, in)).

%% addone(A,B) :- empty(A), empty(B).
%% addone(A,B) :- head(A,C), my_succ(C,D), tail(A,E), addone(E,F), cons(D,F,B).

max_body(6).
max_vars(6).

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

:- body_literal(0,head,_,_).
:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.


%% addone(A,B) :- empty(A), empty(B).
%% addone(A,B) :- head(A,C), my_succ(C,D), tail(A,E), addone(E,F), cons(D,F,B).

max_body(5).
max_vars(5).
max_ho(1).

enable_recursion.


body_pred(changesign,2).
type(changesign,(element,element)).
direction(changesign,(in,out)).

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

body_pred(triple,2).
type(triple,(element,element)).
direction(triple,(in,out)).

body_pred(square,2).
type(square,(element,element)).
direction(square,(in,out)).

body_pred(double,2).
type(double,(element,element)).
direction(double,(in,out)).

body_pred(bin,2).
type(bin,(element,element)).
direction(bin,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(negative,1).
type(negative,(element,)).
direction(negative,(in,)).

body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).


body_pred(addlast1,2).
type(addlast1,(list,list)).
direction(addlast1,(in,out)).

body_pred(addhead1,2).
type(addhead1,(list,list)).
direction(addhead1,(in,out)).

body_pred(duplhead,2).
type(duplhead,(list,list)).
direction(duplhead,(in,out)).



:- body_literal(0,head,_,_).
:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

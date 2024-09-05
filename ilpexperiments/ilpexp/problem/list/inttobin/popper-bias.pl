head_pred(inttobin,2).
type(inttobin,(list, list)).
direction(inttobin,(in,in)).

body_pred(bin,2).
type(bin,(element,element)).
direction(bin,(in,out)).


max_body(6).
max_vars(6).

% inttobin(A,B) :- empty(A), empty(B).
% inttobin(A,B) :- tail(A,D) head(A,C), bin(C,E), inttobin(D,F), cons(E,F,B).

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

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

:- body_literal(0,head,_,_).
:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.


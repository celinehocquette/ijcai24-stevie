

head_pred(chartobin,2).
type(chartobin,(list, list)).
direction(chartobin,(in,in)).

max_body(6).
max_vars(6).
max_ho(1).
enable_recursion.

% chartobin(A,B) :- empty(A), empty(B).
% chartobin(A,B) :- tail(A,D) head(A,C), ord(C,G), bin(G,E), chartobin(D,F), cons(E,F,B).

body_pred(bin,2).
type(bin,(element,element)).
direction(bin,(in,out)).

body_pred(ord,2).
type(ord,(element,element)).
direction(ord,(in,out)).

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

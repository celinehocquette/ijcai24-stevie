

body_pred(negative,1).
type(negative,(element,)).
direction(negative,(in,)).

body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).

max_body(6).
max_vars(5).
max_clauses(3).

body_pred(cons,3).
type(cons,(element,list,list)).
direction(cons,(in,in,out)).

:-
    body_literal(0,head,_,_).
:-
    body_literal(0,tail,_,_).
:-
    body_literal(1,empty,_,_).
:-
    body_literal(2,empty,_,_).

%     filter_negative(A,E) :-  empty(A), empty(E)
%     filter_negative(A,E) :-  head(A,B), positive(B), tail(A,C), filter_negative(C,D), head(B,D), tail(B,E)
%     filter_negative(A,D) :-  head(A,B), negative(B), tail(A,C), filter_negative(C,D)

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

body_pred(one,1).
type(one,(element,)).
direction(one,(out,)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).


:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.


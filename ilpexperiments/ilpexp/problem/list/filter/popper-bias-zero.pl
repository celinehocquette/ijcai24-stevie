

max_body(4).
max_vars(5).
max_clauses(3).

:-
    body_literal(0,cons3,_,_).
:-
    body_literal(0,cons,_,_).

%     filter_negative(A,E) :-  empty(A), empty(E)
%     filter_negative(A,E) :-  head(A,B), positive(B), tail(A,C), filter_negative(C,D), cons(B,D,E)
%     filter_negative(A,D) :-  head(A,B), negative(B), tail(A,C), filter_negative(C,D)

enable_recursion.

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(cons,3).
type(cons,(element,list,list)).
direction(cons,(in,in,out)).

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

body_pred(cons3,3).
type(cons3,(list,element,list)).
direction(cons3,(in,out,out)).


:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

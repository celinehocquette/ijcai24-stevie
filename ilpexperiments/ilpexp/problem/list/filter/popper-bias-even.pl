
max_body(5).
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


body_pred(cons3,3).
type(cons3,(list,element,list)).
direction(cons3,(in,out,out)).

body_pred(cons,3).
type(cons,(element,list,list)).
direction(cons,(in,in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).


:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

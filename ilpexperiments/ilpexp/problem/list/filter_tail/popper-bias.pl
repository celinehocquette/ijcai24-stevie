

body_pred(negative,1).
type(negative,(element,)).
direction(negative,(in,)).

body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).

body_pred(tail,2).
type(tail,(list, list)).
direction(tail,(in, out)).

max_body(5).
max_vars(5).
max_clauses(3).


%     filter_negative(A,E) :-  empty(A), empty(E)
%     filter_negative(A,E) :-  head(A,B), positive(B), tail(A,C), filter_negative(C,D), cons(B,D,E)
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

body_pred(cons,3).
type(cons,(list,element,list)).
direction(cons,(in,out,out)).


:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

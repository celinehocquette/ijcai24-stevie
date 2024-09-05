head_pred(sorted_double,1).
type(sorted_double,(list,)).
direction(sorted_double,(in,)).

enable_recursion.

body_pred(my_double,2).
type(my_double,(element,element)).
direction(my_double,(in,in)).

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

max_body(6).
max_vars(6).

%sorted_incr(A):- empty(A).
%sorted_incr(A):- head(A,B),tail(A,C),head(C,D),sorted_incr(C),geq(B,D).

:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

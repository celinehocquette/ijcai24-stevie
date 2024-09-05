head_pred(increment_seq,1).
type(increment_seq,(list,)).
direction(increment_seq,(in,)).


enable_recursion.

body_pred(incrementin,2).
type(incrementin,(element,element)).
direction(incrementin,(in,in)).


body_pred(negative,1).
type(negative,(element,)).
direction(negative,(in,)).

body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).


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

:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

head_pred(sorted_decr,1).
type(sorted_decr,(list,)).
direction(sorted_decr,(in,)).

enable_recursion.

body_pred(geq,2).
type(geq,(element,element)).
direction(geq,(in,in)).

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

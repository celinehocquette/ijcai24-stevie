head_pred(decrement_seq4,1).
type(decrement_seq4,(list,)).
direction(decrement_seq4,(in,)).

enable_recursion.

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).


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

max_body(5).
max_vars(5).
max_ho(1).


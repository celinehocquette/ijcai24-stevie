

body_pred(rotate1,2).
type(rotate1,(list,list)).
direction(rotate1,(in,out)).

enable_recursion.
max_body(3).
max_vars(4).
max_ho(1).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).

body_pred(negative,1).
type(negative,(element,)).
direction(negative,(in,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).


body_pred(zero,1).
type(zero,(element,)).
direction(zero,(in,)).

body_pred(one,1).
type(one,(element,)).
direction(one,(in,)).


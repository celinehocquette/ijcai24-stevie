
max_clauses(3).
max_body(5).
max_vars(4).
enable_recursion.

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

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
direction(one,(in,)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(in,)).


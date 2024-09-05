head_pred(dropuntilodd,2).
type(dropuntilodd,(list,list)).
direction(dropuntilodd,(in,out)).

max_body(3).
max_vars(4).

enable_recursion.

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).



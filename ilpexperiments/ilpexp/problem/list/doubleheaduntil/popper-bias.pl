head_pred(doubleheaduntil,2).
type(doubleheaduntil,(list,list)).
direction(doubleheaduntil,(in,out)).

body_pred(doublehead,2).
type(doublehead,(list,list)).
direction(doublehead,(in,out)).


body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).

body_pred(c128,1).
type(c128,(element,)).
direction(c128,(in,)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

enable_recursion.
max_body(3).
max_vars(4).


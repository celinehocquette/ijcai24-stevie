head_pred(dropuntilthree,2).
type(dropuntilthree,(list,list)).
direction(dropuntilthree,(in,out)).

max_vars(5).
max_body(5).

enable_recursion.


body_pred(decrement,2).
type(decrement,(element, element)).
direction(decrement,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

head_pred(membertwo,1).
type(membertwo,(list,)).
direction(membertwo,(in,)).

max_body(6).
max_vars(6).
enable_recursion.

body_pred(decrement,2).
type(decrement,(element, element)).
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

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).



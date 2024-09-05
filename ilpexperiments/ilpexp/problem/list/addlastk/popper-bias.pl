

%enable_recursion.

max_body(6).
max_vars(6).
max_ho(3).

body_pred(addlast1,2).
type(addlast1,(list,list)).
direction(addlast1,(in,out)).



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
head_pred(decrement1until,2).
type(decrement1until,(list,list)).
direction(decrement1until,(in,out)).

body_pred(decrementhead1,2).
type(decrementhead1,(list,list)).
direction(decrementhead1,(in,out)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

enable_recursion.
max_body(3).
max_vars(4).


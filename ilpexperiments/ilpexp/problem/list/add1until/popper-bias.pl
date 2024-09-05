head_pred(add1until,2).
type(add1until,(list,list)).
direction(add1until,(in,out)).

body_pred(addhead1,2).
type(addhead1,(list,list)).
direction(addhead1,(in,out)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).


enable_recursion.
max_body(3).
max_vars(4).




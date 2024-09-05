head_pred(iteratedrop3k,3).
type(iteratedrop3k,(element,list,list)).
direction(iteratedrop3k,(in,in,out)).


max_ho(3).
max_vars(5).
max_body(5).

enable_recursion.

body_pred(eq_list,2).
type(eq_list,(list,list)).
direction(eq_list,(in,out)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(empty_in,1).
type(empty_in,(list,)).
direction(empty_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

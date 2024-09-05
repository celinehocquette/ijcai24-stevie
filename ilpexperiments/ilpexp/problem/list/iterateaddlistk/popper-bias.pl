head_pred(iterateaddlistk,3).
type(iterateaddlistk,(element,list,list)).
direction(iterateaddlistk,(in,in,out)).

max_clauses(3).
max_body(3).
max_vars(4).

enable_recursion.

body_pred(eq_list,2).
type(eq_list,(list,list)).
direction(eq_list,(in,out)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(empty_in,1).
type(empty_in,(list,)).
direction(empty_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).


:- body_literal(_,iterateaddlistk,_,(B,C,_)), C>B.
head_pred(iterateaddheadk,3).
type(iterateaddheadk,(element,list,list)).
direction(iterateaddheadk,(in,in,out)).

max_ho(3).

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

body_pred(addhead1,2).
type(addhead1,(list,list)).
direction(addhead1,(in,out)).

:- body_literal(_,iterateaddheadk,_,(B,C,_)), C>B.
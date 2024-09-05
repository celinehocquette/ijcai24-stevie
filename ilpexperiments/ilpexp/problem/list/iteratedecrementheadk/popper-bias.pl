head_pred(iteratedecrementheadk,3).
type(iteratedecrementheadk,(element,list,list)).
direction(iteratedecrementheadk,(in,in,out)).


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

:- body_literal(_,iteratedecrementheadk,_,(B,C,_)), C>B.

body_pred(decrementhead1,2).
type(decrementhead1,(list,list)).
direction(decrementhead1,(in,out)).


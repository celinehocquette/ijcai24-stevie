head_pred(f,3).
type(f,(element,list,list)).
direction(f,(in,in,out)).

body_pred(cons1,3).
type(cons1,(list, element, list)).
direction(cons1,(in,in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(less0,1).
type(less0,(element,)).
direction(less0,(in,)).


body_pred(eq_list,2).
type(eq_list,(list,list)).
direction(eq_list,(in,out)).

:- bad.
bad :- body_literal(_,P,_,_), body_pred_lgrounding(_,(eq_list,),P,_,_).
bad :- body_literal(_,P,_,_), body_pred_lgrounding(_,(eq_list,_),P,_,_).
bad :- body_literal(_,P,_,_), body_pred_lgrounding(_,(_,eq_list),P,_,_).


body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.
max_ho(1).
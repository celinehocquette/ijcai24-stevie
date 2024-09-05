

% repeatN(A,B) :- zero(A), empty(B).
% repeatN(A,B) :- decrement(A,C), repeatN(C,D), head(A,B),

enable_recursion.

head_pred(iteraterepeatN,3).
type(iteraterepeatN,(element,list,list)).
direction(iteraterepeatN,(in,in,out)).

body_pred(empty_in,1).
type(empty_in,(list,)).
direction(empty_in,(in,)).


body_pred(eq_list,2).
type(eq_list,(list,list)).
direction(eq_list,(in,out)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

body_pred(duplhead,2).
type(duplhead,(list,list)).
direction(duplhead,(in,out)).


:- body_literal(_,iteraterepeatN,_,(B,C,_)), C>B.
%map_p_a(A,B):-suc(A,B).
%caseint_q_a(A,B,C):-map_a(B,D),caseint_a(A,D,C).
%f(A,B,C):-caseint_a(A,B,C).
%caseint_p_a(A,B):-eqs(A,B).

head_pred(f,3).
type(f,(element,list,list)).
direction(f,(in,in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(cons1,2).
type(cons1,(list,element,list)).
direction(cons1,(in,in,out)).

body_pred(cons3,2).
type(cons3,(list,element,list)).
direction(cons3,(in,out,out)).



body_pred(zero,1).
type(zero,(element,)).
direction(zero,(in,)).

body_pred(less0,1).
type(less0,(element,)).
direction(less0,(in,)).


body_pred(eq_list,2).
type(eq_list,(list,list)).
direction(eq_list,(in,out)).


body_pred(empty,1).
type(empty,(list,)).
direction(empty,(in,)).

max_vars(5).
max_clauses(2).
max_body(5).
max_ho(1).
enable_recursion.

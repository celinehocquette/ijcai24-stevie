

max_body(4).
max_vars(4).
max_clauses(3).
enable_recursion.

body_pred(my_increment,2).
type(my_increment,(int,int)).
direction(my_increment,(in,out)).

%body_pred(prepend,3).
%type(prepend,(element,list,list)).
%direction(prepend,(out,out,in)).

%enable_negation.

:- body_literal(0,tail,_,_).
:- body_literal(0,head,_,_).

body_pred(negative,1).
type(negative,(element,)).
direction(negative,(in,)).

body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).


body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).

body_pred(one_int,1).
type(one_int,(int,)).
direction(one_int,(out,)).

body_pred(zero_int,1).
type(zero_int,(int,)).
direction(zero_int,(out,)).

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).


%ho_569(A,B,P,Q) :- empty(A),zero_int(B)
%ho_569(A,B,P,Q) :- head(A,C),tail(A,D),P(C),ho_569(D,B,P,Q)
%ho_569(A,B,P,Q) :- head(A,C),tail(A,D),Q(C),ho_569(D,E,P,Q),increment(E,B)
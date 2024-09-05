

max_body(5).
max_vars(5).
max_clauses(3).
enable_recursion.


body_pred(my_increment,2).
type(my_increment,(int,int)).
direction(my_increment,(in,out)).

%body_pred(prepend,3).
%type(prepend,(element,list,list)).
%direction(prepend,(out,out,in)).

%enable_negation.

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(zero_int,1).
type(zero_int,(int,)).
direction(zero_int,(out,)).

body_pred(one,1).
type(one,(element,)).
direction(one,(in,)).

body_pred(minusone,1).
type(minusone,(element,)).
direction(minusone,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

%ho_569(A,B,P,Q) :- empty(A),zero_int(B)
%ho_569(A,B,P,Q) :- head(A,C),tail(A,D),P(C),ho_569(D,B,P,Q)
%ho_569(A,B,P,Q) :- head(A,C),tail(A,D),Q(C),ho_569(D,E,P,Q),increment(E,B)


:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.
:- body_literal(0,head,_,_).
:- body_literal(0,tail,_,_).
:- body_literal(0,my_increment,_,_).

head_pred(allpositive,1).
type(allpositive,(list,)).
direction(allpositive,(in,)).

body_pred(positive,1).
type(positive,(element,)).
direction(positive,(in,)).

max_body(6).
max_vars(6).
enable_recursion.

%% allpositive(A) :- empty(A).
%% allpositive(A):- head(A,B),positive(B),tail(A,C),allpositive(C).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(in,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).

:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

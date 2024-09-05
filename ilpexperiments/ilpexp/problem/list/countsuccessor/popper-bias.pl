

max_body(5).
max_vars(4).
max_clauses(3).
enable_recursion.

body_pred(my_increment,2).
type(my_increment,(int,int)).
direction(my_increment,(in,out)).

%enable_negation.

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


:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

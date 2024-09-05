head_pred(maxlist,2).
type(maxlist,(list, element)).
direction(maxlist,(in,out)).

body_pred(max,3).
type(max,(element,element,element)).
direction(max,(in,in,out)).


%% maxlist(A,B) :- empty(A), zero(B).
%% maxlist(A,B) :- head(A,C), tail(A,D), maxlist(D,E), max(C,E,B).

max_body(6).
max_vars(6).
max_clauses(3).


enable_recursion.


body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).

body_pred(one,1).
type(one,(element,)).
direction(one,(out,)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.

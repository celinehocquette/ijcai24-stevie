head_pred(minlist,2).
type(minlist,(list, element)).
direction(minlist,(in,out)).

body_pred(min,3).
type(min,(element,element,element)).
direction(min,(in,in,out)).



%% minlist(A,B) :- head(A,B).
%% minlist(A,B) :- head(A,C), tail(A,D), minlist(D,E), min(C,E,B).
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

body_pred(c100,1).
type(c100,(element,)).
direction(c100,(out,)).

:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.
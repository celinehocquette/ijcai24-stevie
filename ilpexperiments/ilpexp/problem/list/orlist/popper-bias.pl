head_pred(orlist,2).
type(orlist,(list,element)).
direction(orlist,(in,out)).

body_pred(or_element,3).
type(or_element,(element, element, element)).
direction(or_element,(in,in,out)).

max_body(5).
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
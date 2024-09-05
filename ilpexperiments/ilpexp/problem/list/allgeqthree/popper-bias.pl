head_pred(allgeqthree,1).
type(allgeqthree,(list,)).
direction(allgeqthree,(in,)).

max_body(6).
max_vars(6).
max_ho(1).
enable_recursion.

body_pred(geq,2).
type(geq,(element,element)).
direction(geq,(in,in)).

body_pred(my_succ,2).
type(my_succ,(element,element)).
direction(my_succ,(out,in)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(in,)).

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

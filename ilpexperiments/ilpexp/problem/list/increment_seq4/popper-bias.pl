head_pred(increment_seq4,1).
type(increment_seq4,(list,)).
direction(increment_seq4,(in,)).

enable_recursion.

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

max_body(4).
max_vars(5).
max_ho(1).

:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.


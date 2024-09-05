head_pred(multlistplus2,2).
type(multlistplus2,(list, element)).
direction(multlistplus2,(in,out)).

body_pred(mult,3).
type(mult,(element, element, element)).
direction(mult,(in, in, out)).

% multlist(A,B):- head(A,B).
% multlist(A,B):- tail(A,C),multlist(C,E),head(A,D),mult(D,E,B).

max_body(5).
max_vars(5).
max_ho(1).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

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
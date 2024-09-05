head_pred(sum_listplus3,2).
type(sum_listplus3,(list, element)).
direction(sum_listplus3,(in,out)).

body_pred(sum,3).
type(sum,(element, element, element)).
direction(sum,(in, in, out)).

body_pred(increment,2).
type(increment,(element, element)).
direction(increment,(in, out)).

%% sum_list(A,B) :- empty(A), zero(B).
%% sum_list(A,B) :- head(A,C), tail(A,D), sum_list(D,E), sum(C,E,B).

max_body(5).
max_vars(4).
max_ho(1).
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
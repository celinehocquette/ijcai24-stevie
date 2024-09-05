head_pred(chartointsum,2).
type(chartointsum,(list, element)).
direction(chartointsum,(in,in)).

body_pred(ord,2).
type(ord,(element,element)).
direction(ord,(in,out)).

body_pred(sum,3).
type(sum,(element, element, element)).
direction(sum,(in, in, out)).

max_body(4).
max_vars(4).
max_clauses(3).
enable_recursion.

% chartoint(A,B) :- empty(A), empty(B).
% chartoint(A,B) :- comps(A,C,D), ord(C,E), chartoint(D,F), cons(E,F,B).


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


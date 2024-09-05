head_pred(chartointsorteddecr,1).
type(chartointsorteddecr,(list,)).
direction(chartointsorteddecr,(in,)).

body_pred(ord,2).
type(ord,(element,element)).
direction(ord,(in,out)).

body_pred(geq,2).
type(geq,(element,element)).
direction(geq,(in,in)).

max_body(5).
max_vars(4).
max_clauses(4).
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

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).

body_pred(zero_in,1).
type(zero_in,(element,)).
direction(zero_in,(in,)).




%fold_p_a(A,B,C):-suc(B,C),geq(C,A).
%f(A):-zero(C),fold_a(C,A,B).

head_pred(sorted,1).
type(sorted,(list,)).
direction(sorted,(in,)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(geq,2).
type(geq,(element,element)).
direction(geq,(in,in)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(pred,2).
type(pred,(element,element)).
direction(pred,(in,out)).

max_vars(5).
max_body(5).
max_clauses(2).
non_datalog.
allow_singletons.
enable_recursion.


%sorted_incr(A):- empty(A).
%sorted_incr(A):- head(A,B),tail(A,C),head(C,D),sorted_incr(C),geq(B,D).
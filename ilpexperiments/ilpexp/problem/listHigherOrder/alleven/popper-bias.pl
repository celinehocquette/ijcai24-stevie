head_pred(alleven,1).
type(alleven,(list,)).
direction(alleven,(in,)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(in,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(in,)).


max_vars(5).
max_clauses(2).
max_body(5).
max_ho(1).
enable_recursion.

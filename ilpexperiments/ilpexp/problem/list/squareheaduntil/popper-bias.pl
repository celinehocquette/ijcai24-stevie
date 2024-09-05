head_pred(squareheaduntil,2).
type(squareheaduntil,(list,list)).
direction(squareheaduntil,(in,out)).

body_pred(squarehead,2).
type(squarehead,(list,list)).
direction(squarehead,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(c256,1).
type(c256,(element,)).
direction(c256,(in,)).


enable_recursion.
max_body(3).
max_vars(4).


max_vars(5).
max_body(5).

head_pred(f,2).
body_pred(add1,2).
body_pred(map,3,ho).

type(f,(list,list)).
type(add1,(element,element)).
type(map,((element,element),list,list)).

direction(f,(in,out)).
direction(add1,(in,out)).
direction(map,((in,out),in,out)).


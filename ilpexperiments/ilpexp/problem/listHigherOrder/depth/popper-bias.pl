


%f(A,B):-children(A,C),fold_a(C,D,zero,f1),suc(D,B).
%f1(A,B,C):-f(B,D),max(D,A,C).

head_pred(f,2).
type(f,(tree,element)).
direction(f,(in,out)).

body_pred(root,2).
type(root,(tree,element)).
direction(root,(in,out)).


body_pred(children,2).
type(children,(tree,list)).
direction(children,(in,out)).

body_pred(max,3).
type(max,(element,element,element)).
direction(max,(in,in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(leaf,1).
type(leaf,(tree,)).
direction(leaf,(out,)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(eq,2).
type(eq,(element,element)).
direction(eq,(in,out)).

max_vars(5).
max_clauses(2).
max_body(5).
max_ho(1).
enable_recursion.

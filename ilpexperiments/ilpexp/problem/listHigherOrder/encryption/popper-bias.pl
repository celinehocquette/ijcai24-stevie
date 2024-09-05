
%f(A,B):-map_a(A,B).
%map_p_a(A,B):-char_to_int(A,E),my_pred(E,D),my_pred(D,C),int_to_char(C,B).

head_pred(f,2).
type(f,(list,list)).
direction(f,(in,in)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).


body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(cons2,3).
type(cons2,(list,element,out)).
direction(cons2,(in,out,out)).

body_pred(char_to_int,2).
type(char_to_int,(element,element)).
direction(char_to_int,(in,out)).

body_pred(int_to_char,2).
type(int_to_char,(element,element)).
direction(int_to_char,(in,out)).

enable_recursion.
max_vars(5).
max_clauses(2).
max_body(5).
max_ho(1).
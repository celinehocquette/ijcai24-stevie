
max_vars(5).
max_clauses(2).
max_body(4).

% switches enabled 
enable_recursion.

%Head predicates
head_pred(f,2).

%Body predicates
body_pred(my_succ,2).
body_pred(my_pred,2).
body_pred(char_to_int,2).
body_pred(int_to_char,2).
body_pred(head,2).
body_pred(tail,2).
body_pred(empty,1).
body_pred(map,2,ho).

%directions 
direction(f,(in,out)).
direction(my_succ,(in,out)).
direction(my_pred,(in,out)).
direction(head,(in,out)).
direction(tail,(in,out)).
direction(int_to_char,(in,out)).
direction(char_to_int,(in,out)).
direction(empty,(out,)).

%types
type(f,(list,list)).
type(my_succ,(num,num)).
type(my_pred,(num,num)).
type(head,(list,char)).
type(tail,(list,list)).
type(int_to_char,(num,char)).
type(char_to_int,(char,num)).
type(empty,(list,)).

%Higher-order directions
direction(map,((in,out),in,out)).


%Higher-order types
type(map,((char,char),list,list)).



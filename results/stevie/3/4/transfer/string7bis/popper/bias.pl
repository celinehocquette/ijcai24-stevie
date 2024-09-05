




max_vars(5).
max_body(4).

body_pred(head,2).
body_pred(tail,2).
body_pred(mk_uppercase,2).
body_pred(mk_lowercase,2).
body_pred(empty,1).
body_pred(is_uppercase,1).
body_pred(is_lowercase,1).
body_pred(is_letter,1).
body_pred(is_number,1).
body_pred(neg_uppercase,1).
body_pred(neg_lowercase,1).
body_pred(neg_letter,1).
body_pred(neg_number,1).

body_pred(cons3,3).
type(cons3,(string,letter,string)).
direction(cons3,(in,out,out)).

body_pred(cons,3).
type(cons,(letter,string,string)).
direction(cons,(in,in,out)).


type(head,(string,letter)).
type(tail,(string,string)).
type(front,(string,string)).
type(mk_uppercase,(letter,letter)).
type(mk_lowercase,(letter,letter)).
type(my_reverse,(string,string)).
type(eq_list,(string,string)).
type(singleton,(letter,string)).
type(empty,(string,)).
type(is_uppercase,(letter,)).
type(is_lowercase,(letter,)).
type(is_letter,(letter,)).
type(is_number,(letter,)).
type(is_space,(letter,)).
type(neg_uppercase,(letter,)).
type(neg_lowercase,(letter,)).
type(neg_letter,(letter,)).
type(neg_number,(letter,)).
type(neg_space,(letter,)).


direction(head,(in,out)).
direction(tail,(in,out)).
direction(front,(in,out)).
direction(mk_uppercase,(in,out)).
direction(mk_lowercase,(in,out)).
direction(my_reverse,(in,out)).
direction(eq_list,(in,out)).
direction(singleton,(in,out)).
direction(empty,(out,)).
direction(is_uppercase,(in,)).
direction(is_lowercase,(in,)).
direction(is_letter,(in,)).
direction(is_number,(in,)).
direction(is_space,(in,)).
direction(neg_uppercase,(in,)).
direction(neg_lowercase,(in,)).
direction(neg_letter,(in,)).
direction(neg_number,(in,)).
direction(neg_space,(in,)).

enable_recursion.

functional.


body_pred(ho_5,2,ho).
body_pred(ho_495,4,ho).
body_pred(ho_267,2,ho).
body_pred(ho_190,4,ho).
body_pred(ho_75,4,ho).
body_pred(ho_1,3,ho).
body_pred(ho_166,3,ho).
body_pred(ho_32,2,ho).
type(ho_1,(string, string, (string, string))).
type(ho_5,(string, (letter, ))).
type(ho_32,(string, (letter, ))).
type(ho_44,(letter, string, string, (string, string))).
type(ho_75,(string, string, (string, string), (letter, ))).
type(ho_124,(string, letter, (letter, ), (letter, ))).
type(ho_166,(string, string, (letter, letter))).
type(ho_190,(string, string, (letter, ), (letter, ))).
type(ho_244,(letter, string, string, (string, string))).
type(ho_267,(string, (letter, letter))).
type(ho_495,(string, letter, (letter, ), (letter, letter, letter))).
direction(ho_1,(in, out, (in, out))).
direction(ho_5,(in, (in, ))).
direction(ho_32,(in, (in, ))).
direction(ho_44,(in, in, out, (in, out))).
direction(ho_75,(in, out, (in, out), (in, ))).
direction(ho_124,(in, out, (in, ), (in, ))).
direction(ho_166,(in, in, (in, out))).
direction(ho_190,(in, out, (in, ), (in, ))).
direction(ho_244,(in, in, out, (in, out))).
direction(ho_267,(in, (in, in))).
direction(ho_495,(in, out, (in, ), (in, in, out))).

head_pred(f7bis,2).
type(f7bis,(string,string)).
direction(f7bis,(in,in)).



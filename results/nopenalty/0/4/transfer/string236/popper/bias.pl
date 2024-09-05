




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


body_pred(ho_355,5,ho).
body_pred(ho_445,4,ho).
body_pred(ho_238,4,ho).
body_pred(ho_222,2,ho).
body_pred(ho_141,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_22,5,ho).
body_pred(ho_160,3,ho).
type(ho_1,(string, string, (string, string))).
type(ho_22,(string, letter, (string, ), (letter, ), (letter, letter, letter))).
type(ho_98,(string, letter, (letter, ), (letter, ), (letter, letter))).
type(ho_141,(string, string, (string, letter), (string, string), (letter, letter))).
type(ho_160,(string, (letter, ), (string, string))).
type(ho_172,(letter, string, string, (string, string))).
type(ho_222,(string, (letter, ))).
type(ho_238,(string, string, (string, string), (letter, ))).
type(ho_241,(letter, string, string, (string, string))).
type(ho_355,(string, string, (letter, ), (letter, ), (letter, string, string))).
type(ho_445,(string, (string, string), (string, letter), (letter, letter))).
direction(ho_1,(in, out, (in, out))).
direction(ho_22,(in, out, (in, ), (in, ), (in, in, out))).
direction(ho_98,(in, in, (in, ), (in, ), (in, out))).
direction(ho_141,(in, in, (in, out), (in, out), (in, out))).
direction(ho_160,(in, (in, ), (in, out))).
direction(ho_172,(in, in, out, (in, out))).
direction(ho_222,(in, (in, ))).
direction(ho_238,(in, out, (in, out), (in, ))).
direction(ho_241,(in, in, out, (in, out))).
direction(ho_355,(in, in, (in, ), (in, ), (in, in, out))).
direction(ho_445,(in, (in, out), (in, out), (in, in))).

head_pred(f236,2).
type(f236,(string,string)).
direction(f236,(in,in)).



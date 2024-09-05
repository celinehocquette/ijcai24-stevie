




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


body_pred(ho_13,3,ho).
body_pred(ho_501,5,ho).
body_pred(ho_317,4,ho).
body_pred(ho_8,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_25,3,ho).
body_pred(ho_53,3,ho).
body_pred(ho_187,5,ho).
type(ho_1,(string, string, (string, string))).
type(ho_8,(string, string, (string, string), (string, letter), (letter, ))).
type(ho_13,(string, (letter, ), (string, string))).
type(ho_25,(string, (string, letter), (letter, ))).
type(ho_36,(letter, string, string, (string, string), (string, string))).
type(ho_53,(string, (string, letter), (letter, letter))).
type(ho_134,(string, letter, (string, string), (letter, ), (letter, ))).
type(ho_187,(string, string, (string, ), (string, letter), (letter, letter))).
type(ho_200,(letter, string, string, (letter, letter), (string, string))).
type(ho_317,(string, letter, (letter, ), (letter, letter, letter))).
type(ho_501,(string, string, (string, letter, string), (letter, ), (letter, ))).
direction(ho_1,(in, out, (in, out))).
direction(ho_8,(in, out, (in, out), (in, out), (in, ))).
direction(ho_13,(in, (in, ), (in, out))).
direction(ho_25,(in, (in, out), (in, ))).
direction(ho_36,(in, in, out, (in, out), (in, out))).
direction(ho_53,(in, (in, out), (in, in))).
direction(ho_134,(in, out, (in, out), (in, ), (in, ))).
direction(ho_187,(in, in, (in, ), (in, out), (in, out))).
direction(ho_200,(in, in, out, (in, out), (in, out))).
direction(ho_317,(in, out, (out, ), (in, in, out))).
direction(ho_501,(in, out, (in, out, out), (in, ), (in, ))).

head_pred(f47,2).
type(f47,(string,string)).
direction(f47,(in,in)).




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



prop(symmetric_ab,eq).
prop(symmetric_ab,eq_list).
prop(asymmetric_ab_ba,head).
prop(asymmetric_ab_ba,tail).
prop(asymmetric_ab_ba,ord).
prop(asymmetric_ab_ba,increment).
prop(asymmetric_ab_ba,decrement).
prop(asymmetric_ab_ba,element).
prop(antitriangular,head).
prop(antitriangular,tail).
prop(antitriangular,ord).
prop(antitriangular,increment).
prop(antitriangular,decrement).
prop(antitriangular,element).
prop(unique_a_b,head).
prop(unique_a_b,tail).
prop(unique_a_b,decrement).
prop(unique_a_b,increment).
prop(unique_a_b,ord).
prop(unique_b_a,decrement).
prop(unique_b_a,increment).
prop(unique_b_a,ord).
prop(asymmetric_ab_ba,head).
prop(asymmetric_ab_ba,tail).
prop(asymmetric_ab_ba,decrement).
prop(asymmetric_ab_ba,increment).
prop(asymmetric_ab_ba,ord).
prop(asymmetric_ab_ba,element).
prop(antitransitive,decrement).
prop(antitransitive,increment).
prop(antitransitive,ord).
prop(antitransitive,element).
prop(antitransitive,head).
prop(antitransitive,tail).
prop(unsat_pair,even,odd).
prop(unsat_pair,one,zero).
prop(unsat_pair,one,even).
prop(unsat_pair,zero,odd).
prop(unsat_pair,positive,negative).
prop(unsat_pair,one,negative).
prop(unsat_pair,decrement,increment).

:-
   head_pred(P,2),
   Rule > 0,
   body_literal(Rule,empty,_,(A,)),
   body_literal(Rule,P,_,(A,_)).


body_pred(ho_13,3,ho).
body_pred(ho_200,5,ho).
body_pred(ho_317,4,ho).
body_pred(ho_134,5,ho).
body_pred(ho_8,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_36,5,ho).
body_pred(ho_25,3,ho).
body_pred(ho_53,3,ho).
body_pred(ho_187,5,ho).
type(ho_1,(list, list, (list, list))).
type(ho_8,(list, list, (list, list), (list, element), (element, ))).
type(ho_13,(list, (element, ), (list, list))).
type(ho_25,(list, (list, element), (element, ))).
type(ho_36,(element, list, list, (list, list), (list, list))).
type(ho_53,(list, (list, element), (element, element))).
type(ho_134,(list, int, (list, list), (element, ), (element, ))).
type(ho_187,(list, list, (list, ), (list, element), (element, element))).
type(ho_200,(element, list, list, (element, element), (list, list))).
type(ho_317,(list, element, (element, ), (element, element, element))).
type(ho_501,(list, list, (list, element, list), (element, ), (element, ))).
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




%ite_p_a(A,B,C):-ite_a(A,C,B).
%f(A,B,C):-zero(D),ite_a(D,A,C,B).
%ite_p_a(A,B):-suc(A,B).

head_pred(f,3).
type(f,(element,element,element)).
direction(f,(in,in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(out,in)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(decrement, 2).
type(decrement,(element,element)).
direction(pred,(in,out)).

body_pred(eq, 2).
type(eq,(element,element)).
direction(eq,(in,out)).

body_pred(less0, 1).
type(less0,(element,)).
direction(less0,(in,)).

max_clauses(3).
max_vars(5).
max_body(5).
enable_recursion.
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


body_pred(ho_444,3,ho).
body_pred(ho_180,5,ho).
body_pred(ho_42,6,ho).
body_pred(ho_329,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_356,4,ho).
body_pred(ho_15,5,ho).
body_pred(ho_8,4,ho).
body_pred(ho_45,2,ho).
type(ho_1,(list, list, (list, list))).
type(ho_8,(list, (list, element), (element, ), (list, list))).
type(ho_15,(list, list, (list, list), (list, element), (element, ))).
type(ho_42,(element, list, list, (element, ), (list, list), (list, list))).
type(ho_45,(list, (element, ))).
type(ho_180,(list, int, (element, ), (element, ), (int, int))).
type(ho_294,(list, list, (list, element, list), (element, ), (element, ))).
type(ho_329,(list, list, (list, ), (list, list), (element, element))).
type(ho_356,(list, element, (element, ), (element, element, element))).
type(ho_444,(list, (list, element), (element, element))).
direction(ho_1,(in, out, (in, out))).
direction(ho_8,(in, (in, out), (in, ), (in, out))).
direction(ho_15,(in, out, (in, out), (in, out), (in, ))).
direction(ho_42,(in, in, out, (in, ), (in, out), (in, out))).
direction(ho_45,(in, (in, ))).
direction(ho_180,(in, in, (in, ), (in, ), (in, out))).
direction(ho_294,(in, out, (in, out, out), (in, ), (in, ))).
direction(ho_329,(in, in, (in, ), (in, out), (in, out))).
direction(ho_356,(in, out, (out, ), (in, in, out))).
direction(ho_444,(in, (in, out), (in, in))).




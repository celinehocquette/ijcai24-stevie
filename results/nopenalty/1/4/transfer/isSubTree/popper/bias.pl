
%f(A,B):-eqs(A,B).
%f(A,B):-children(A,C),any_a(C,B).
%any_p_a(A,B):-f(A,B).

head_pred(f,2).
type(f,(tree,tree)).
direction(f,(in,in)).

body_pred(eq,2).
type(eq,(tree,tree)).
direction(eq,(in,out)).

body_pred(children,2).
type(children,(tree,list)).
direction(children,(in,out)).

body_pred(root,2).
type(root,(tree,element)).
direction(root,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,tree)).
direction(head,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).


max_vars(5).
max_body(5).
max_clauses(2).
max_ho(1).
enable_recursion.


% f(A,B) :- eq(A,B).
% f(A,B) :- children(A,C), ho_374(C,B,f).



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


body_pred(ho_19,4,ho).
body_pred(ho_33,2,ho).
body_pred(ho_213,5,ho).
body_pred(ho_405,4,ho).
body_pred(ho_610,5,ho).
body_pred(ho_135,5,ho).
body_pred(ho_76,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_144,4,ho).
body_pred(ho_138,2,ho).
body_pred(ho_287,5,ho).
type(ho_1,(list, list, (list, list))).
type(ho_19,(list, list, (list, list), (element, ))).
type(ho_33,(list, (element, ))).
type(ho_76,(element, list, list, (list, list), (list, list))).
type(ho_135,(list, list, (list, ), (list, element), (element, element))).
type(ho_138,(list, (element, ))).
type(ho_144,(element, list, list, (list, list))).
type(ho_213,(list, element, (element, ), (list, list), (element, element, element))).
type(ho_287,(list, int, (list, element), (element, ), (element, ))).
type(ho_405,(list, (list, list), (list, ), (element, element))).
type(ho_496,(list, list, (list, ), (element, ), (element, ))).
type(ho_610,(list, element, (list, ), (element, ), (element, element, element))).
direction(ho_1,(in, out, (in, out))).
direction(ho_19,(in, out, (in, out), (in, ))).
direction(ho_33,(in, (in, ))).
direction(ho_76,(in, in, out, (in, out), (in, out))).
direction(ho_135,(in, in, (in, ), (in, out), (in, out))).
direction(ho_138,(in, (in, ))).
direction(ho_144,(in, in, out, (in, out))).
direction(ho_213,(in, out, (in, ), (in, out), (in, in, out))).
direction(ho_287,(in, out, (in, out), (in, ), (in, ))).
direction(ho_405,(in, (in, out), (in, ), (in, in))).
direction(ho_496,(in, out, (in, ), (in, ), (in, ))).
direction(ho_610,(in, out, (in, ), (in, ), (in, in, out))).



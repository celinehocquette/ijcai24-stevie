% caselist_r_a(A,B,C):-front(B,E),caselist_a(E,D),app(D,A,C).
% caselist_p_a(A):-empty(A).
% f(A,B):-reverse(A,C),caselist_a(C,B).
% caselist_q_a(A,B):-any(A),empty(B).

head_pred(f,2).
type(f,(list,list)).
direction(f,(in,out)).

body_pred(front,2).
type(front,(list,list)).
direction(front,(in,out)).

body_pred(cons1,3).
type(cons1,(list,element,list)).
direction(cons1,(in,in,out)).

body_pred(reverse,2).
type(reverse,(list,list)).
direction(reverse,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(any,1).
type(any,(element,)).
direction(any,(in,)).

max_vars(5).
max_body(5).
max_clauses(4).
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


body_pred(ho_65,2,ho).
body_pred(ho_21,4,ho).
body_pred(ho_48,4,ho).
body_pred(ho_286,4,ho).
body_pred(ho_26,2,ho).
body_pred(ho_194,2,ho).
body_pred(ho_1,3,ho).
body_pred(ho_143,3,ho).
body_pred(ho_5,4,ho).
type(ho_1,(list, list, (list, list))).
type(ho_5,(element, list, list, (list, list))).
type(ho_21,(list, list, (list, list), (element, ))).
type(ho_26,(list, (element, ))).
type(ho_48,(list, element, (element, ), (element, element, element))).
type(ho_65,(list, (element, element))).
type(ho_143,(list, list, (element, element))).
type(ho_176,(list, list, (element, ), (element, ))).
type(ho_194,(list, (element, ))).
type(ho_286,(list, int, (element, ), (element, ))).
direction(ho_1,(in, out, (in, out))).
direction(ho_5,(in, in, out, (in, out))).
direction(ho_21,(in, out, (in, out), (in, ))).
direction(ho_26,(in, (in, ))).
direction(ho_48,(in, out, (in, ), (in, in, out))).
direction(ho_65,(in, (in, in))).
direction(ho_143,(in, in, (in, out))).
direction(ho_176,(in, out, (in, ), (in, ))).
direction(ho_194,(in, (in, ))).
direction(ho_286,(in, out, (in, ), (in, ))).




%f(A,B):-map(map_p_a,A,B).
%map_p_a(A,B):-reverse(A,C),tail(C,D),reverse(D,B).

head_pred(droplast,2).
type(droplast,(list,list)).
direction(droplast,(in,in)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(reverse,2).
type(reverse,(list,list)).
direction(reverse,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(cons3,3).
type(cons3,(list,element,list)).
direction(cons3,(in,out,out)).

max_vars(5).
max_body(5).
max_clauses(3).
max_ho(1).
enable_recursion.


% dropLast(A, B):- map(A, B, p).
% p(A, B):- reverse(A, C), tail(C, D), reverse(D, B).




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


body_pred(ho_244,4,ho).
body_pred(ho_5,2,ho).
body_pred(ho_495,4,ho).
body_pred(ho_267,2,ho).
body_pred(ho_124,4,ho).
body_pred(ho_44,4,ho).
body_pred(ho_75,4,ho).
body_pred(ho_1,3,ho).
body_pred(ho_166,3,ho).
body_pred(ho_32,2,ho).
type(ho_1,(list, list, (list, list))).
type(ho_5,(list, (element, ))).
type(ho_32,(list, (element, ))).
type(ho_44,(element, list, list, (list, list))).
type(ho_75,(list, list, (list, list), (element, ))).
type(ho_124,(list, int, (element, ), (element, ))).
type(ho_166,(list, list, (element, element))).
type(ho_190,(list, list, (element, ), (element, ))).
type(ho_244,(element, list, list, (list, list))).
type(ho_267,(list, (element, element))).
type(ho_495,(list, element, (element, ), (element, element, element))).
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




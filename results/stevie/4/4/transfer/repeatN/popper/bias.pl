
%f(A,B,C):-empty(D),ite_a(D,B,C,A).
%ite_p_a(A,B,C):-app(A,C,B).

head_pred(f,3).
type(f,(list,element,list)).
direction(f,(in,in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(append,3).
type(append,(list,list,list)).
direction(append,(in,in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

max_vars(5).
max_body(5).
max_clauses(2).
enable_recursion.
max_ho(1).

% repeatN(A,B,C):- empty(D), iterate(A,B,D,C,append).



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


body_pred(ho_319,2,ho).
body_pred(ho_9,2,ho).
body_pred(ho_109,4,ho).
body_pred(ho_137,4,ho).
body_pred(ho_1,3,ho).
body_pred(ho_6,4,ho).
body_pred(ho_290,2,ho).
body_pred(ho_378,4,ho).
body_pred(ho_251,3,ho).
body_pred(ho_500,4,ho).
type(ho_1,(list, list, (list, list))).
type(ho_6,(list, list, (list, list), (element, ))).
type(ho_9,(list, (element, element))).
type(ho_109,(list, element, (element, ), (element, element, element))).
type(ho_137,(list, int, (element, ), (element, ))).
type(ho_251,(list, list, (element, element))).
type(ho_270,(list, list, (element, ), (element, ))).
type(ho_290,(list, (element, ))).
type(ho_319,(list, (element, ))).
type(ho_378,(list, element, (element, ), (element, element, element))).
type(ho_500,(element, list, list, (list, list))).
type(ho_734,(list, (element, element))).
direction(ho_1,(in, out, (in, out))).
direction(ho_6,(in, out, (in, out), (in, ))).
direction(ho_9,(in, (in, in))).
direction(ho_109,(in, out, (out, ), (in, in, out))).
direction(ho_137,(in, out, (in, ), (in, ))).
direction(ho_251,(in, in, (in, out))).
direction(ho_270,(in, out, (in, ), (in, ))).
direction(ho_290,(in, (in, ))).
direction(ho_319,(in, (in, ))).
direction(ho_378,(in, out, (in, ), (in, in, out))).
direction(ho_500,(in, in, out, (in, out))).
direction(ho_734,(in, (in, in))).




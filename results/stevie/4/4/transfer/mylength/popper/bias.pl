
%% f(A,B) :- empty(A),zero(B).
%% f(A,B) :- tail(A,D),f(D,C),succ(C,B).

head_pred(mylength,2).
type(mylength,(list,element)).
direction(mylength,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(one,1).
type(one,(element,)).
direction(one,(out,)).

max_vars(5).
max_body(5).
max_clauses(2).
non_datalog.
allow_singletons.
enable_recursion.



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




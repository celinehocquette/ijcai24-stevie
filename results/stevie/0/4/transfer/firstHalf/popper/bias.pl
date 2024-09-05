

%inv_ho_0(A,B,C):- head(A,B),tail(A,C).
%inv_ho_1(A,B):- decrement(A,C),decrement(C,B).
%f(A,B):- len(A,C),ite(C,A,B,inv_ho_1,inv_ho_0).

%ite(A,_,C,P,Q) :- zero(A), empty(C).
%ite(A,B,C,P,Q) :- call(P,A,D), head(B,E), tail(B,F), call(Q,C,E,G),ite(D,F,G,P,Q).


%ite_p_a(A,B):-pred(A,C),pred(C,B).
%ite_q_a(A,B,C):-head(A,B),tail(A,C).
%f(A,B):-len(A,C),ite_a(A,C,B).

head_pred(f,2).
type(f,(list,list)).
direction(f,(in,out)).

body_pred(head,2).
type(head,(list,tree)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(decrement,2).
type(decrement,(element,element)).
direction(decrement,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).


body_pred(len,2).
type(len,(list,element)).
direction(len,(in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).


body_pred(any,1).
type(any,(element,)).
direction(any,(in,)).

body_pred(cons1,3).
type(cons1,(list,element,list)).
direction(cons1,(in,in,out)).

max_vars(5).
max_clauses(3).
max_body(5).
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


body_pred(ho_185,3,ho).
body_pred(ho_16,4,ho).
body_pred(ho_1,3,ho).
body_pred(ho_132,4,ho).
body_pred(ho_44,2,ho).
body_pred(ho_308,2,ho).
body_pred(ho_6,2,ho).
body_pred(ho_251,4,ho).
body_pred(ho_101,4,ho).
type(ho_1,(list, list, (list, list))).
type(ho_6,(list, (element, ))).
type(ho_16,(element, list, list, (list, list))).
type(ho_44,(list, (element, ))).
type(ho_101,(list, element, (element, ), (element, element, element))).
type(ho_132,(list, int, (element, ), (element, ))).
type(ho_185,(list, list, (element, element))).
type(ho_251,(list, list, (list, list), (element, ))).
type(ho_308,(list, (element, element))).
type(ho_489,(list, list, (element, ), (element, ))).
direction(ho_1,(in, out, (in, out))).
direction(ho_6,(in, (in, ))).
direction(ho_16,(in, in, out, (in, out))).
direction(ho_44,(in, (in, ))).
direction(ho_101,(in, out, (in, ), (in, in, out))).
direction(ho_132,(in, out, (in, ), (in, ))).
direction(ho_185,(in, in, (in, out))).
direction(ho_251,(in, out, (in, out), (in, ))).
direction(ho_308,(in, (in, in))).
direction(ho_489,(in, out, (in, ), (in, ))).




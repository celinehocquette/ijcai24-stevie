
%fold_p_a(A,B,C):-suc(B,C),geq(C,A).
%f(A):-zero(C),fold_a(C,A,B).

head_pred(sorted,1).
type(sorted,(list,)).
direction(sorted,(in,)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(geq,2).
type(geq,(element,element)).
direction(geq,(in,in)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(increment,2).
type(increment,(element,element)).
direction(increment,(in,out)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).

body_pred(pred,2).
type(pred,(element,element)).
direction(pred,(in,out)).

max_vars(5).
max_body(5).
max_clauses(2).
non_datalog.
allow_singletons.
enable_recursion.


%sorted_incr(A):- empty(A).
%sorted_incr(A):- head(A,B),tail(A,C),head(C,D),sorted_incr(C),geq(B,D).



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


body_pred(ho_24,4,ho).
body_pred(ho_511,4,ho).
body_pred(ho_14,2,ho).
body_pred(ho_61,3,ho).
body_pred(ho_44,4,ho).
body_pred(ho_316,4,ho).
body_pred(ho_234,4,ho).
body_pred(ho_5,4,ho).
body_pred(ho_186,2,ho).
body_pred(ho_1,3,ho).
body_pred(ho_153,2,ho).
type(ho_1,(list, list, (list, list))).
type(ho_5,(list, list, (list, list), (element, ))).
type(ho_14,(list, (element, ))).
type(ho_24,(element, list, list, (list, list))).
type(ho_44,(list, element, (element, ), (element, element, element))).
type(ho_61,(list, list, (element, element))).
type(ho_102,(list, list, (element, ), (element, ))).
type(ho_153,(list, (element, ))).
type(ho_186,(list, (element, element))).
type(ho_234,(element, list, list, (list, list))).
type(ho_316,(list, int, (element, ), (element, ))).
type(ho_511,(list, element, (element, ), (element, element, element))).
direction(ho_1,(in, out, (in, out))).
direction(ho_5,(in, out, (in, out), (in, ))).
direction(ho_14,(in, (in, ))).
direction(ho_24,(in, in, out, (in, out))).
direction(ho_44,(in, out, (out, ), (in, in, out))).
direction(ho_61,(in, in, (in, out))).
direction(ho_102,(in, out, (in, ), (in, ))).
direction(ho_153,(in, (in, ))).
direction(ho_186,(in, (in, in))).
direction(ho_234,(in, in, out, (in, out))).
direction(ho_316,(in, out, (in, ), (in, ))).
direction(ho_511,(in, out, (in, ), (in, in, out))).




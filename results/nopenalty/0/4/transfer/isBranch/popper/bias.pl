
%casetree_p_a(A,B):-tail(B,C),empty(C),head(B,A).
%any_p_a(A,B):-tail(B,C),casetree_a(A,C).
%casetree_q_a(A,B,C):-head(C,A),any_a(B,C).
%f(A,B):-casetree_a(A,B).

head_pred(f,2).
type(f,(tree,list)).
direction(f,(in,in)).

body_pred(children,2).
type(children,(tree,list)).
direction(children,(in,out)).

body_pred(root,2).
type(root,(tree,element)).
direction(root,(in,out)).


body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).

body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

max_vars(5).
max_clauses(4).
max_body(5).

% switches enabled
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


body_pred(ho_241,4,ho).
body_pred(ho_355,5,ho).
body_pred(ho_445,4,ho).
body_pred(ho_238,4,ho).
body_pred(ho_222,2,ho).
body_pred(ho_141,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_172,4,ho).
body_pred(ho_98,5,ho).
body_pred(ho_22,5,ho).
body_pred(ho_160,3,ho).
type(ho_1,(list, list, (list, list))).
type(ho_22,(list, element, (list, ), (element, ), (element, element, element))).
type(ho_98,(list, int, (element, ), (element, ), (int, int))).
type(ho_141,(list, list, (list, element), (list, list), (element, element))).
type(ho_160,(list, (element, ), (list, list))).
type(ho_172,(element, list, list, (list, list))).
type(ho_222,(list, (element, ))).
type(ho_238,(list, list, (list, list), (element, ))).
type(ho_241,(element, list, list, (list, list))).
type(ho_355,(list, list, (element, ), (element, ), (element, list, list))).
type(ho_445,(list, (list, list), (list, element), (element, element))).
direction(ho_1,(in, out, (in, out))).
direction(ho_22,(in, out, (in, ), (in, ), (in, in, out))).
direction(ho_98,(in, in, (in, ), (in, ), (in, out))).
direction(ho_141,(in, in, (in, out), (in, out), (in, out))).
direction(ho_160,(in, (in, ), (in, out))).
direction(ho_172,(in, in, out, (in, out))).
direction(ho_222,(in, (in, ))).
direction(ho_238,(in, out, (in, out), (in, ))).
direction(ho_241,(in, in, out, (in, out))).
direction(ho_355,(in, in, (in, ), (in, ), (in, in, out))).
direction(ho_445,(in, (in, out), (in, out), (in, in))).




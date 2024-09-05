head_pred(andlist,2).
type(andlist,(list,element)).
direction(andlist,(in,out)).

body_pred(xor,3).
type(xor,(element, element, element)).
direction(xor,(in,in,out)).

%xorlist(A,B) :- empty(A), zero(B).
%xorlist(A,B) :- comps(A,C,D), xorlist(D,E), xor(C,E,B).

max_body(5).
max_vars(6).
max_clauses(3).

enable_recursion.


body_pred(empty,1).
type(empty,(list,)).
direction(empty,(out,)).

body_pred(even,1).
type(even,(element,)).
direction(even,(in,)).

body_pred(odd,1).
type(odd,(element,)).
direction(odd,(in,)).

body_pred(one,1).
type(one,(element,)).
direction(one,(out,)).

body_pred(zero,1).
type(zero,(element,)).
direction(zero,(out,)).


body_pred(and_element,3).
type(and_element,(element, element, element)).
direction(and_element,(in,in,out)).

:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.


%enable_pi.

body_pred(head,2).
type(head,(list,element)).
direction(head,(in,out)).

body_pred(tail,2).
type(tail,(list,list)).
direction(tail,(in,out)).


prop(symmetric_ab_c,or_element).
prop(symmetric_ab_c,and_element).
prop(symmetric_ab_c,max).
prop(symmetric_ab_c,min).
prop(symmetric_ab_c,mult).
prop(symmetric_ab_c,sum).
prop(symmetric_ab_c,xor).
prop(symmetric_ab,eq).
prop(unique_ab_c,or_element).
prop(unique_ab_c,and_element).
prop(unique_ab_c,max).
prop(unique_ab_c,min).
prop(unique_ab_c,mult).
prop(unique_ab_c,sum).
prop(unique_ab_c,cons).
prop(unique_ab_c,cons2).
prop(unique_ac_b,mult).
prop(unique_ac_b,sum).
prop(unique_ac_b,cons).
prop(unique_ac_b,cons2).
prop(unique_bc_a,mult).
prop(unique_bc_a,sum).
prop(unique_bc_a,cons).
prop(unique_bc_a,cons2).
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
prop(unique_a_b,bin).
prop(unique_a_b,double).
prop(unique_a_b,triple).
prop(unique_a_b,decrementhead1).
prop(unique_a_b,addhead1).
prop(unique_b_a,decrement).
prop(unique_b_a,increment).
prop(unique_b_a,ord).
prop(unique_b_a,bin).
prop(unique_b_a,double).
prop(unique_b_a,triple).
prop(unique_b_a,duplhead).
prop(unique_b_a,decrementhead1).
prop(unique_b_a,addhead1).
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


:-
   head_pred(P,2),
   Rule > 0,
   body_literal(Rule,empty,_,(A,)),
   body_literal(Rule,P,_,(A,_)).


prop(not_abc_bc,(or_element,my_decrement)).
prop(not_ab_ab,(my_decrement,my_triple)).
prop(not_ab_ba,(decrement,ord)).
prop(not_ab_ab,(changesign,decrementin)).
prop(not_ab_ab,(geq,increment)).
prop(not_ab_ba,(my_triple,increment)).
prop(not_abc_ba,(and_element,ord)).
prop(not_ab_ab,(my_triple,ord)).
prop(not_abc_ac,(and_element,incrementin)).
prop(not_a_a,(even,odd)).
prop(not_ab_ab,(increment,my_decrement)).
prop(not_ab_ab,(bin,increment)).
prop(not_ab_bc,(my_decrement,ord)).
prop(not_ab_ba,(eq_list,tail)).
prop(not_ab_ab,(bin,decrementin)).
prop(not_ab_ba,(bin,ord)).
prop(not_ab_cb,(decrementin,ord)).
prop(not_ab_bc,(decrementin,ord)).
prop(not_ab_ab,(decrementin,double)).
prop(not_ab_bc,(increment,ord)).
prop(not_ab_ca,(my_triple,ord)).
prop(not_ab_cb,(bin,ord)).
prop(not_ab_ba,(bin,incrementin)).
prop(not_abc_ca,(and_element,decrement)).
prop(not_ab_ba,(my_triple,my_decrement)).
prop(not_abc_bc,(or_element,decrementin)).
prop(not_abc_ba,(mult,ord)).
prop(not_ab_ba,(decrement,bin)).
prop(not_ab_a,(decrementin,zero)).
prop(not_ab_ba,(addlast1,addlast1)).
prop(not_ab_bc,(geq,my_double)).
prop(not_abc_ca,(mult,ord)).
prop(not_abc_ca,(max,ord)).
prop(not_ab_ba,(changesign,ord)).
prop(not_ab_ba,(increment,changesign)).
prop(not_ab_ac,(changesign,ord)).
prop(not_ab_ab,(decrementin,incrementin)).
prop(not_abc_ac,(max,decrementin)).
prop(not_ab_ba,(my_decrement,decrement)).
prop(not_abc_bd,(sum,ord)).
prop(not_abc_b,(and_element,negative)).
prop(not_ab_bc,(changesign,ord)).
prop(not_ab_ba,(incrementin,my_triple)).
prop(not_ab_b,(decrement,negative)).
prop(not_ab_b,(incrementin,zero_in)).
prop(not_abc_ca,(cons3,eq_list)).
prop(not_ab_b,(decrementin,negative)).
prop(not_ab_a,(increment,negative)).
prop(not_abc_ac,(or_element,decrementin)).
prop(not_abc_ab,(or_element,my_double)).
prop(not_abc_ad,(max,ord)).
prop(not_ab_ba,(duplhead,eq_list)).
prop(not_ab_ba,(geq,ord)).
prop(not_abc_ad,(sum,ord)).
prop(not_abc_ca,(min,my_double)).
prop(not_a_a,(even,one)).
prop(not_abc_ad,(and_element,ord)).
prop(not_abc_ac,(min,ord)).
prop(not_abc_cb,(min,ord)).
prop(not_ab_ab,(decrementhead1,tail)).
prop(not_abc_cb,(or_element,my_double)).
prop(not_ab_ba,(decrementin,decrementin)).
prop(not_ab_ac,(increment,ord)).
prop(not_ab_ab,(addhead1,tail)).
prop(not_ab_ac,(decrement,ord)).
prop(not_abc_bc,(and_element,increment)).
prop(not_ab_ba,(addlast1,duplhead)).
prop(not_ab_ba,(addlast1,addhead1)).
prop(not_abc_ab,(and_element,ord)).
prop(not_ab_ba,(my_decrement,ord)).
prop(not_abc_bc,(and_element,incrementin)).
prop(not_ab_ac,(geq,ord)).
prop(not_ab_bc,(bin,my_double)).
prop(not_a_a,(negative,zero)).
prop(not_ab_ab,(double,ord)).
prop(not_abc_ca,(cons3,decrementhead1)).
prop(not_abc_cd,(and_element,ord)).
prop(not_ab_ba,(decrementhead1,tail)).
prop(not_abc_ad,(mult,ord)).
prop(not_a_a,(one,zero_int)).
prop(not_abc_cb,(or_element,incrementin)).
prop(not_ab_a,(head,empty)).
prop(not_ab_ab,(geq,my_double)).
prop(not_ab_ba,(geq,decrementin)).
prop(not_ab_bc,(geq,ord)).
prop(not_ab_ba,(my_triple,decrement)).
prop(not_ab_ba,(tail,decrementhead1)).
prop(not_ab_ba,(eq_list,addlast1)).
prop(not_abc_bd,(cons3,ord)).
prop(not_abc_cd,(sum,ord)).
prop(not_abc_ca,(cons3,addlast1)).
prop(not_abc_ca,(and_element,my_decrement)).
prop(not_ab_ba,(decrement,decrementin)).
prop(not_ab_ba,(changesign,increment)).
prop(not_ab_ba,(increment,ord)).
prop(not_ab_b,(bin,negative)).
prop(not_ab_ba,(duplhead,duplhead)).
prop(not_ab_ac,(double,ord)).
prop(not_abc_ba,(and_element,my_double)).
prop(not_a_a,(one_in,zero_in)).
prop(not_ab_ba,(double,my_double)).
prop(not_ab_b,(addhead1,empty)).
prop(not_abc_cb,(min,decrement)).
prop(not_ab_a,(decrementin,negative)).
prop(not_ab_b,(increment,zero)).
prop(not_ab_ba,(tail,addlast1)).
prop(not_ab_ab,(incrementin,ord)).
prop(not_abc_cd,(mult,ord)).
prop(not_ab_b,(decrementhead1,empty)).
prop(not_ab_ab,(decrementin,increment)).
prop(not_ab_ab,(bin,incrementin)).
prop(not_ab_ba,(incrementin,double)).
prop(not_ab_b,(incrementin,zero_int)).
prop(not_abc_ac,(sum,ord)).
prop(not_ab_a,(incrementin,negative)).
prop(not_ab_ba,(incrementin,increment)).
prop(not_ab_ba,(tail,addhead1)).
prop(not_ab_ab,(bin,my_decrement)).
prop(not_ab_ab,(decrementin,my_triple)).
prop(not_ab_ab,(decrementhead1,duplhead)).
prop(not_abc_bd,(min,ord)).
prop(not_a_a,(odd,zero_in)).
prop(not_ab_b,(my_triple,one)).
prop(not_abc_bc,(max,my_decrement)).
prop(not_ab_ab,(incrementin,my_triple)).
prop(not_ab_b,(double,one_in)).
prop(not_ab_ba,(my_triple,decrementin)).
prop(not_ab_ba,(decrement,my_triple)).
prop(not_abc_bc,(min,increment)).
prop(not_ab_ba,(double,increment)).
prop(not_ab_ab,(decrement,increment)).
prop(not_ab_a,(my_decrement,zero_in)).
prop(not_abc_cd,(or_element,ord)).
prop(not_ab_ba,(addlast1,tail)).
prop(not_abc_ac,(min,my_double)).
prop(not_abc_bc,(min,ord)).
prop(not_ab_ba,(duplhead,addhead1)).
prop(not_a_a,(one,zero_in)).
prop(not_ab_ba,(decrementin,decrement)).
prop(not_ab_ba,(my_decrement,my_triple)).
prop(not_ab_cb,(bin,my_double)).
prop(not_abc_bd,(or_element,ord)).
prop(not_ab_ac,(bin,ord)).
prop(not_ab_a,(my_decrement,zero_int)).
prop(not_ab_ba,(geq,decrement)).
prop(not_ab_ba,(geq,my_decrement)).
prop(not_abc_ac,(or_element,my_decrement)).
prop(not_abc_ca,(cons3,addhead1)).
prop(not_a_a,(negative,one)).
prop(not_ab_ac,(my_triple,my_double)).
prop(not_ab_ba,(duplhead,addlast1)).
prop(not_ab_ba,(duplhead,decrementhead1)).
prop(not_ab_ac,(my_decrement,ord)).
prop(not_ab_ba,(addhead1,addhead1)).
prop(not_ab_b,(increment,zero_int)).
prop(not_abc_ca,(or_element,increment)).
prop(not_abc_ca,(mult,my_double)).
prop(not_abc_ac,(cons3,addhead1)).
prop(not_abc_ca,(min,decrement)).
prop(not_abc_cb,(min,my_double)).
prop(not_ab_ab,(changesign,my_decrement)).
prop(not_abc_ac,(cons3,addlast1)).
prop(not_ab_ba,(addlast1,decrementhead1)).
prop(not_abc_bc,(max,decrementin)).
prop(not_ab_ba,(changesign,my_decrement)).
prop(not_ab_b,(my_decrement,negative)).
prop(not_ab_ba,(my_decrement,geq)).
prop(not_ab_ab,(duplhead,tail)).
prop(not_ab_bc,(bin,ord)).
prop(not_ab_ba,(increment,my_triple)).
prop(not_abc_cb,(and_element,my_decrement)).
prop(not_abc_ac,(min,incrementin)).
prop(not_ab_ab,(changesign,my_double)).
prop(not_ab_ba,(double,ord)).
prop(not_ab_ab,(double,my_decrement)).
prop(not_ab_a,(addhead1,empty)).
prop(not_a_a,(odd,zero)).
prop(not_abc_a,(and_element,negative)).
prop(not_ab_ba,(bin,decrement)).
prop(not_ab_a,(decrement,zero)).
prop(not_abc_ab,(or_element,ord)).
prop(not_ab_ba,(bin,decrementin)).
prop(not_ab_a,(decrement,negative)).
prop(not_ab_a,(decrementin,zero_in)).
prop(not_abc_ac,(and_element,my_double)).
prop(not_ab_ab,(decrement,ord)).
prop(not_ab_b,(my_triple,one_in)).
prop(not_ab_a,(duplhead,empty)).
prop(not_ab_ba,(eq_list,decrementhead1)).
prop(not_ab_ab,(geq,incrementin)).
prop(not_ab_ab,(changesign,increment)).
prop(not_ab_ab,(decrement,my_double)).
prop(not_ab_bc,(decrement,ord)).
prop(not_ab_ba,(incrementin,incrementin)).
prop(not_ab_ba,(decrement,decrement)).
prop(not_abc_ca,(max,incrementin)).
prop(not_ab_ab,(changesign,incrementin)).
prop(not_ab_ac,(my_triple,ord)).
prop(not_abc_cb,(and_element,decrement)).
prop(not_abc_ac,(or_element,ord)).
prop(not_abc_cd,(max,ord)).
prop(not_ab_ab,(addhead1,duplhead)).
prop(not_ab_ab,(my_decrement,ord)).
prop(not_ab_ba,(my_triple,my_double)).
prop(not_ab_ba,(decrementin,my_triple)).
prop(not_abc_ac,(and_element,ord)).
prop(not_ab_ba,(my_decrement,my_decrement)).
prop(not_ab_ab,(addlast1,eq_list)).
prop(not_ab_ab,(decrement,double)).
prop(not_abc_bd,(mult,ord)).
prop(not_ab_ba,(my_decrement,changesign)).
prop(not_ab_ab,(eq_list,tail)).
prop(not_ab_ba,(decrementhead1,addlast1)).
prop(not_a_a,(even,one_in)).
prop(not_ab_ba,(eq_list,addhead1)).
prop(not_abc_ca,(min,ord)).
prop(not_ab_b,(increment,negative)).
prop(not_ab_ab,(decrementin,ord)).
prop(not_abc_bd,(max,ord)).
prop(not_abc_c,(or_element,negative)).
prop(not_abc_ca,(min,decrementin)).
prop(not_abc_ba,(or_element,my_double)).
prop(not_a_a,(odd,zero_int)).
prop(not_ab_ba,(bin,my_decrement)).
prop(not_abc_ca,(cons3,tail)).
prop(not_abc_ca,(or_element,my_double)).
prop(not_abc_ab,(mult,ord)).
prop(not_abc_cb,(min,my_decrement)).
prop(not_ab_ba,(decrement,my_double)).
prop(not_abc_cb,(mult,my_double)).
prop(not_ab_ab,(decrement,incrementin)).
prop(not_abc_ba,(max,ord)).
prop(not_ab_ba,(my_triple,incrementin)).
prop(not_abc_ac,(min,increment)).
prop(not_ab_b,(incrementin,negative)).
prop(not_ab_ba,(increment,my_double)).
prop(not_abc_ca,(and_element,ord)).
prop(not_abc_ca,(and_element,decrementin)).
prop(not_ab_ba,(bin,my_double)).
prop(not_ab_ab,(addlast1,decrementhead1)).
prop(not_abc_ac,(and_element,increment)).
prop(not_abc_ac,(cons3,decrementhead1)).
prop(not_a_a,(negative,positive)).
prop(not_ab_b,(increment,zero_in)).
prop(not_ab_ba,(incrementin,changesign)).
prop(not_ab_ab,(bin,decrement)).
prop(not_ab_ab,(decrement,my_triple)).
prop(not_abc_ad,(or_element,ord)).
prop(not_ab_ba,(incrementin,my_double)).
prop(not_ab_a,(my_decrement,negative)).
prop(not_abc_ac,(max,my_decrement)).
prop(not_abc_ab,(sum,ord)).
prop(not_ab_a,(decrementhead1,empty)).
prop(not_ab_ab,(addhead1,eq_list)).
prop(not_abc_b,(or_element,negative)).
prop(not_ab_ab,(increment,ord)).
prop(not_abc_bc,(and_element,my_double)).
prop(not_ab_ba,(increment,bin)).
prop(not_ab_bc,(incrementin,ord)).
prop(not_abc_cd,(min,ord)).
prop(not_abc_ac,(mult,ord)).
prop(not_ab_ba,(decrementhead1,decrementhead1)).
prop(not_abc_ad,(min,ord)).
prop(not_ab_ba,(decrementhead1,eq_list)).
prop(not_abc_ba,(min,ord)).
prop(not_ab_ba,(addlast1,eq_list)).
prop(not_ab_ab,(decrementhead1,eq_list)).
prop(not_ab_ba,(increment,incrementin)).
prop(not_abc_bc,(max,decrement)).
prop(not_ab_ba,(decrementin,my_double)).
prop(not_ab_ab,(geq,ord)).
prop(not_ab_ab,(decrementin,my_double)).
prop(not_ab_ba,(decrement,changesign)).
prop(not_abc_c,(and_element,negative)).
prop(not_ab_a,(decrementin,zero_int)).
prop(not_abc_ca,(min,my_decrement)).
prop(not_ab_ba,(incrementin,bin)).
prop(not_ab_ba,(bin,increment)).
prop(not_ab_ab,(addlast1,duplhead)).
prop(not_abc_bc,(max,ord)).
prop(not_ab_a,(decrement,zero_in)).
prop(not_abc_cb,(and_element,ord)).
prop(not_ab_b,(incrementin,zero)).
prop(not_abc_bc,(and_element,ord)).
prop(not_abc_cb,(and_element,decrementin)).
prop(not_ab_ac,(incrementin,ord)).
prop(not_ab_ab,(duplhead,eq_list)).
prop(not_abc_cba,(cons3,cons3)).
prop(not_ab_a,(addlast1,empty)).
prop(not_ab_bc,(my_triple,ord)).
prop(not_ab_a,(my_decrement,zero)).
prop(not_abc_ab,(min,ord)).
prop(not_ab_ba,(increment,double)).
prop(not_abc_cda,(cons3,cons3)).
prop(not_abc_bc,(or_element,ord)).
prop(not_abc_ab,(and_element,my_double)).
prop(not_ab_ab,(my_decrement,my_double)).
prop(not_ab_ba,(decrement,my_decrement)).
prop(not_a_a,(negative,one_in)).
prop(not_ab_ba,(changesign,my_double)).
prop(not_abc_cb,(and_element,my_double)).
prop(not_abc_cb,(min,decrementin)).
prop(not_ab_ac,(decrementin,ord)).
prop(not_ab_ba,(changesign,decrement)).
prop(not_ab_ba,(decrementin,ord)).
prop(not_abc_ba,(sum,ord)).
prop(not_ab_ba,(eq_list,duplhead)).
prop(not_ab_ba,(tail,eq_list)).
prop(not_ab_ab,(bin,my_double)).
prop(not_ab_ba,(decrementin,changesign)).
prop(not_ab_ab,(addhead1,addlast1)).
prop(not_abc_cb,(max,incrementin)).
prop(not_ab_b,(duplhead,empty)).
prop(not_abc_cb,(max,increment)).
prop(not_ab_ab,(changesign,ord)).
prop(not_ab_b,(addlast1,empty)).
prop(not_ab_ba,(decrementin,bin)).
prop(not_a_a,(one_in,zero)).
prop(not_ab_ab,(increment,my_triple)).
prop(not_abc_bd,(and_element,ord)).
prop(not_ab_ab,(bin,ord)).
prop(not_abc_cb,(or_element,increment)).
prop(not_abc_ac,(cons3,eq_list)).
prop(not_abc_a,(or_element,negative)).
prop(not_ab_ba,(changesign,decrementin)).
prop(not_ab_ba,(decrementhead1,duplhead)).
prop(not_ab_ab,(incrementin,my_decrement)).
prop(not_abc_bc,(sum,ord)).
prop(not_abc_ca,(or_element,ord)).
prop(not_ab_ba,(addhead1,duplhead)).
prop(not_abc_ac,(or_element,my_double)).
prop(not_ab_ba,(decrement,geq)).
prop(not_ab_ba,(decrementin,my_decrement)).
prop(not_ab_ba,(changesign,incrementin)).
prop(not_ab_ba,(my_triple,ord)).
prop(not_ab_ba,(my_decrement,bin)).
prop(not_ab_ba,(addhead1,eq_list)).
prop(not_ab_ba,(addhead1,tail)).
prop(not_abc_ac,(or_element,decrement)).
prop(not_ab_b,(double,odd)).
prop(not_abc_bc,(mult,ord)).
prop(not_abc_cb,(max,ord)).
prop(not_abc_ab,(max,ord)).
prop(not_ab_ab,(changesign,decrement)).
prop(not_ab_ba,(my_decrement,decrementin)).
prop(not_ab_ba,(double,incrementin)).
prop(not_abc_ca,(max,increment)).
prop(not_ab_ba,(incrementin,ord)).
prop(not_a_a,(one,zero)).
prop(not_ab_ba,(tail,tail)).
prop(not_ab_ab,(addhead1,decrementhead1)).
prop(not_abc_cb,(mult,ord)).
prop(not_abc_ba,(or_element,ord)).
prop(not_abc_ca,(and_element,my_double)).
prop(not_abc_ac,(max,ord)).
prop(not_a_a,(one_in,zero_int)).
prop(not_a_a,(negative,zero_int)).
prop(not_ab_ab,(addlast1,tail)).
prop(not_ab_ba,(increment,increment)).
prop(not_ab_a,(tail,empty)).
prop(not_a_a,(negative,zero_in)).
prop(not_ab_ba,(decrementin,geq)).
prop(not_abc_bc,(or_element,my_double)).
prop(not_abc_ac,(max,my_double)).
prop(not_ab_ba,(addhead1,addlast1)).
prop(not_abc_ca,(or_element,incrementin)).
prop(not_abc_ca,(sum,ord)).
prop(not_abc_bc,(or_element,decrement)).
:- prop(not_abc_acb,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,C,B)).
:- prop(not_ab_ab,(P,Q)), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(A,B)).
:- prop(not_abc_c,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,)).
:- prop(not_abc_cde,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,_,_)).
:- prop(not_abc_cad,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,A,_)).
:- prop(not_abc_dec,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,_,C)).
:- prop(not_ab_ba,(P,Q)), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(B,A)).
:- prop(not_abc_deb,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,_,B)).
:- prop(not_abc_ca,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,A)).
:- prop(not_abc_adc,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,_,C)).
:- prop(not_abc_ad,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,_)).
:- prop(not_abc_bac,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,A,C)).
:- prop(not_a_a,(P,Q)), body_literal(Rule,P,_,(A,)), body_literal(Rule,Q,_,(A,)).
:- prop(not_abc_cda,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,_,A)).
:- prop(not_abc_abc,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,B,C)).
:- prop(not_abc_dbc,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,B,C)).
:- prop(not_abc_dcb,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,C,B)).
:- prop(not_abc_ab,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,B)).
:- prop(not_abc_da,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,A)).
:- prop(not_abc_cba,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,B,A)).
:- prop(not_abc_cbd,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,B,_)).
:- prop(not_abc_ba,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,A)).
:- prop(not_ab_a,(P,Q)), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(A,)).
:- prop(not_ab_ac,(P,Q)), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(A,_)).
:- prop(not_abc_bdc,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,_,C)).
:- prop(not_ab_cb,(P,Q)), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(_,B)).
:- prop(not_abc_bd,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,_)).
:- prop(not_abc_db,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,B)).
:- prop(not_ab_b,(P,Q)), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(B,)).
:- prop(not_abc_cab,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,A,B)).
:- prop(not_abc_cd,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,_)).
:- prop(not_abc_dae,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,A,_)).
:- prop(not_abc_ade,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,_,_)).
:- prop(not_abc_dbe,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,B,_)).
:- prop(not_abc_a,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,)).
:- prop(not_abc_ac,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,C)).
:- prop(not_abc_dce,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,C,_)).
:- prop(not_abc_cb,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,B)).
:- prop(not_ab_bc,(P,Q)), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(B,_)).
:- prop(not_abc_bda,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,_,A)).
:- prop(not_abc_acd,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,C,_)).
:- prop(not_abc_dea,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,_,A)).
:- prop(not_abc_bde,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,_,_)).
:- prop(not_abc_b,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,)).
:- prop(not_abc_cdb,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(C,_,B)).
:- prop(not_abc_dba,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,B,A)).
:- prop(not_abc_dc,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,C)).
:- prop(not_abc_dca,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,C,A)).
:- prop(not_abc_bca,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,C,A)).
:- prop(not_abc_bc,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,C)).
:- prop(not_abc_bad,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,A,_)).
:- prop(not_abc_abd,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,B,_)).
:- prop(not_abc_dab,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,A,B)).
:- prop(not_abc_adb,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(A,_,B)).
:- prop(not_abc_bcd,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(B,C,_)).
:- prop(not_abc_dac,(P,Q)), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,Q,_,(_,A,C)).
:- prop(not_ab_ca,(P,Q)), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(_,A)).

:- body_literal(R,head,_,(A,B)), body_literal(R,tail,_,(A,C)),C<B.


body_pred(ho_368,5,ho).
body_pred(ho_328,5,ho).
body_pred(ho_41,6,ho).
body_pred(ho_13,4,ho).
body_pred(ho_288,5,ho).
body_pred(ho_211,5,ho).
type(ho_13,(list, list, (list, list), (element, ))).
type(ho_41,(element, list, list, (element, ), (list, list), (list, list))).
type(ho_211,(list, int, (int, ), (element, ), (element, ))).
type(ho_288,(list, list, (element, ), (element, ), (element, list, list))).
type(ho_328,(list, list, (list, ), (list, list), (element, element))).
type(ho_368,(list, element, (list, ), (element, ), (element, element, element))).
direction(ho_13,(in, out, (in, out), (in, ))).
direction(ho_41,(in, in, out, (in, ), (in, out), (in, out))).
direction(ho_211,(in, out, (in, ), (in, ), (in, ))).
direction(ho_288,(in, in, (in, ), (in, ), (in, in, out))).
direction(ho_328,(in, in, (in, ), (in, out), (in, out))).
direction(ho_368,(in, out, (in, ), (in, ), (in, in, out))).




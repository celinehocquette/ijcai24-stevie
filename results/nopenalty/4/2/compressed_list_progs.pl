ho_1(A,B,P) :- P(A,C),P(C,D),P(D,E),P(E,F),P(F,B)
addlast5(A,B) :- ho_1(A,B,addlast1)
addhead5(A,B) :- ho_1(A,B,addhead1)
duplheadk5(A,B) :- ho_1(A,B,duplhead)
repeatminushead5(A,B) :- ho_1(A,B,minushead1)
repeatminuslast5(A,B) :- ho_1(A,B,minuslast1)
ho_14(A,P,Q,R) :- P(A)
ho_14(A,P,Q,R) :- Q(A,B),tail(A,C),R(B),ho_14(C,P,Q,R)
allpositiveallodd(A) :- ho_14(A,empty,head,odd)
allnegative(A) :- ho_14(A,empty,head,negative)
allone(A) :- ho_14(A,empty,head,one_in)
allzero(A) :- ho_14(A,empty,head,zero_in)
ho_53(A,B,P,Q,R) :- P(A),P(B)
ho_53(A,B,P,Q,R) :- Q(A,C),tail(A,D),Q(B,E),tail(B,F),R(C,E),ho_53(D,F,P,Q,R)
maptimestwo(A,B) :- ho_53(A,B,empty,head,double)
mapcube(A,B) :- ho_53(A,B,empty,head,cube)
mapminusone(A,B) :- ho_53(A,B,empty,head,decrement)
chartoint(A,B) :- ho_53(A,B,empty,head,ord)
ho_55(A,B,P) :- empty(A),zero(B)
ho_55(A,B,P) :- head(A,C),tail(A,D),ho_55(D,E,P),P(C,E,B)
sum_list(A,B) :- ho_55(A,B,sum)
orlist(A,B) :- ho_55(A,B,or_element)
ho_118(A,B,P,Q) :- P(A,B),head(B,C),Q(C)
ho_118(A,B,P,Q) :- P(A,C),ho_118(C,B,P,Q)
rotateuntilone(A,B) :- ho_118(A,B,rotate1,one)
decrement1until(A,B) :- ho_118(A,B,decrementhead1,zero_in)
dropuntileven(A,B) :- ho_118(A,B,tail,even)
dropuntilodd(A,B) :- ho_118(A,B,tail,odd)
ho_151(A,B,P,Q,R) :- P(A),P(B)
ho_151(A,B,P,Q,R) :- cons3(A,C,D),Q(C),ho_151(D,B,P,Q,R)
ho_151(A,B,P,Q,R) :- cons3(A,C,D),R(C),ho_151(D,E,P,Q,R),cons(C,E,B)
filter_odd(A,B) :- ho_151(A,B,empty,odd,even)
filter_positive(A,B) :- ho_151(A,B,empty,positive,negative)
filter_even(A,B) :- ho_151(A,B,empty,even,odd)
ho_166(A,P) :- head(A,B),P(B)
ho_166(A,P) :- tail(A,B),ho_166(B,P)
memberzero(A) :- ho_166(A,zero_in)
memberminusone(A) :- ho_166(A,minusone)
memberodd(A) :- ho_166(A,odd)
ho_183(A,B,C,P,Q) :- P(A),eq_list(B,C)
ho_183(A,B,C,P,Q) :- decrement(A,D),ho_183(D,B,E,P,Q),Q(E,C)
iterateaddheadk(A,B,C) :- ho_183(A,B,C,zero_in,addhead1)
iterateaddlastk(A,B,C) :- ho_183(A,B,C,zero_in,addlast1)
iteratedecrementheadk(A,B,C) :- ho_183(A,B,C,zero_in,decrementhead1)
ho_248(A,B,P,Q,R) :- empty(A),P(B)
ho_248(A,B,P,Q,R) :- head(A,C),tail(A,D),Q(C),ho_248(D,B,P,Q,R)
ho_248(A,B,P,Q,R) :- head(A,C),tail(A,D),R(C),ho_248(D,E,P,Q,R),my_increment(E,B)
count_positive(A,B) :- ho_248(A,B,zero_int,negative,positive)
count_zero(A,B) :- ho_248(A,B,zero_int,one,zero_in)
count_negative(A,B) :- ho_248(A,B,zero_int,positive,negative)
count_even(A,B) :- ho_248(A,B,zero_int,odd,even)
ho_432(A,P,Q) :- P(A,B),empty(B)
ho_432(A,P,Q) :- head(A,B),P(A,C),ho_432(C,P,Q),head(C,D),Q(B,D)
sorted_triple(A) :- ho_432(A,tail,my_triple)
sorted_double(A) :- ho_432(A,tail,my_double)
alltwo(A) :- empty(A)
alltwo(A) :- head(A,B),tail(A,C),decrement(B,D),one_in(D),alltwo(C)
addlast5(A,B) :- addlast1(A,C),addlast1(C,D),addlast1(D,E),addlast1(E,F),addlast1(F,B)
addhead5(A,B) :- addhead1(A,C),addhead1(C,D),addhead1(D,E),addhead1(E,F),addhead1(F,B)
dropuntilthree(A,B) :- tail(A,B),head(B,C),decrement(C,D),decrement(D,E),one_in(E)
dropuntilthree(A,B) :- tail(A,C),dropuntilthree(C,B)
duplheadk5(A,B) :- duplhead(A,C),duplhead(C,D),duplhead(D,E),duplhead(E,F),duplhead(F,B)
iteratedropk(A,B,C) :- zero_in(A),eq_list(B,C)
iteratedropk(A,B,C) :- decrement(A,D),tail(B,E),iteratedropk(D,E,C)
multlist(A,B) :- empty(A),one(B)
multlist(A,B) :- head(A,C),tail(A,D),multlist(D,E),mult(E,C,B)
membertwo(A) :- head(A,B),decrement(B,C),one_in(C)
membertwo(A) :- tail(A,B),membertwo(B)
repeatminushead5(A,B) :- minushead1(A,C),minushead1(C,D),minushead1(D,E),minushead1(E,F),minushead1(F,B)
repeatminuslast5(A,B) :- minuslast1(A,C),minuslast1(C,D),minuslast1(D,E),minuslast1(E,F),minuslast1(F,B)
memberthree(A) :- head(A,B),decrement(B,C),decrement(C,D),one_in(D)
memberthree(A) :- tail(A,B),memberthree(B)
allpositivememberone(A) :- head(A,B),tail(A,C),one_in(B),head(C,D),odd(D)
allpositivememberone(A) :- head(A,B),tail(A,C),even(B),head(C,D),one_in(D)
allpositivememberone(A) :- head(A,B),tail(A,C),positive(B),allpositivememberone(C)

 stevie time 0.9273675839999997
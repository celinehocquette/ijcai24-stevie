ho_1(A,B,P) :- P(A,C),P(C,D),P(D,E),P(E,F),P(F,B)
dropfirst5(A,B) :- ho_1(A,B,tail)
addhead5(A,B) :- ho_1(A,B,addhead1)
duplheadk5(A,B) :- ho_1(A,B,duplhead)
repeatminushead5(A,B) :- ho_1(A,B,minushead1)
ho_8(A,B,P,Q,R) :- P(A,B),Q(B,C),R(C)
ho_8(A,B,P,Q,R) :- P(A,C),ho_8(C,B,P,Q,R)
dropuntilodd(A,B) :- ho_8(A,B,tail,head,odd)
add1until(A,B) :- ho_8(A,B,addhead1,head,zero_in)
dropuntileven(A,B) :- ho_8(A,B,tail,head,even)
squareheaduntil(A,B) :- ho_8(A,B,squarehead,head,c256)
ho_15(A,P,Q,R) :- P(A,B),Q(B)
ho_15(A,P,Q,R) :- R(A,B),ho_15(B,P,Q,R)
memberminusone(A) :- ho_15(A,head,minusone,tail)
memberone(A) :- ho_15(A,head,one_in,tail)
membereven(A) :- ho_15(A,head,even,tail)
memberodd(A) :- ho_15(A,head,odd,tail)
ho_26(A,P,Q,R) :- empty(A)
ho_26(A,P,Q,R) :- P(A,B),Q(A,C),R(B),ho_26(C,P,Q,R)
allodd(A) :- ho_26(A,head,tail,odd)
allzero(A) :- ho_26(A,head,tail,zero_in)
allpositive(A) :- ho_26(A,head,tail,positive)
ho_57(A,P,Q,R) :- P(A,B),Q(B)
ho_57(A,P,Q,R) :- head(A,B),P(A,C),ho_57(C,P,Q,R),head(C,D),R(B,D)
increment_seq(A) :- ho_57(A,tail,empty,incrementin)
sorted_triple(A) :- ho_57(A,tail,empty,my_triple)
ho_152(A,B,P,Q,R) :- empty(A),zero_int(B)
ho_152(A,B,P,Q,R) :- head(A,C),P(A,D),Q(C),ho_152(D,B,P,Q,R)
ho_152(A,B,P,Q,R) :- head(A,C),P(A,D),R(C),ho_152(D,E,P,Q,R),my_increment(E,B)
count_negative(A,B) :- ho_152(A,B,tail,positive,negative)
count_positive(A,B) :- ho_152(A,B,tail,negative,positive)
count_one(A,B) :- ho_152(A,B,tail,zero_in,one)
ho_187(A,B,P,Q,R) :- P(A),P(B)
ho_187(A,B,P,Q,R) :- head(A,C),Q(A,D),head(B,E),Q(B,F),R(C,E),ho_187(D,F,P,Q,R)
mapcube(A,B) :- ho_187(A,B,empty,tail,cube)
mapaddone(A,B) :- ho_187(A,B,empty,tail,increment)
chartoint(A,B) :- ho_187(A,B,empty,tail,ord)
inttobin(A,B) :- ho_187(A,B,empty,tail,bin)
ho_305(A,B,P) :- empty(A),one(B)
ho_305(A,B,P) :- head(A,C),tail(A,D),ho_305(D,E,P),P(E,C,B)
andlist(A,B) :- ho_305(A,B,and_element)
maxlist(A,B) :- ho_305(A,B,max)
ho_490(A,B,P,Q) :- empty(A),empty(B)
ho_490(A,B,P,Q) :- cons3(A,C,D),P(C),ho_490(D,B,P,Q)
ho_490(A,B,P,Q) :- cons3(A,C,D),Q(C),ho_490(D,E,P,Q),cons(C,E,B)
filter_even(A,B) :- ho_490(A,B,even,odd)
filter_one(A,B) :- ho_490(A,B,one_in,zero_in)
iterateaddheadk(A,B,C) :- zero_in(A),eq_list(B,C)
iterateaddheadk(A,B,C) :- decrement(A,D),addhead1(B,E),iterateaddheadk(D,E,C)
alltwo(A) :- empty(A)
alltwo(A) :- head(A,B),tail(A,C),decrement(B,D),one_in(D),alltwo(C)
twomembers_0_2(A) :- tail(A,B),head(B,C),decrement(C,D),one(D)
twomembers_0_2(A) :- tail(A,B),tail(B,C),twomembers_0_2(C)
twomembers_0_2(A) :- tail(A,B),tail(B,C),tail(C,D),twomembers_0_2(D)
mapchangesign(A,B) :- empty(A),empty(B)
mapchangesign(A,B) :- head(A,C),tail(A,D),head(B,E),tail(B,F),changesign(C,E),mapchangesign(F,D)
repeatminushead5(A,B) :- minushead1(A,C),minushead1(C,D),minushead1(D,E),minushead1(E,F),minushead1(F,B)
iteraterepeatN(A,B,C) :- zero_in(A),eq_list(B,C)
iteraterepeatN(A,B,C) :- decrement(A,D),iteraterepeatN(D,B,E),duplhead(E,C)
allthree(A) :- empty(A)
allthree(A) :- head(A,B),tail(A,C),decrement(B,D),allthree(C),decrement(D,E),one_in(E)
twomembers_0_1(A) :- tail(A,B),head(B,C),zero(C)
twomembers_0_1(A) :- tail(A,B),tail(B,C),twomembers_0_1(C)
twomembers_0_1(A) :- head(A,B),tail(A,C),odd(B),twomembers_0_1(C)
allgeqtwo(A) :- empty(A)
allgeqtwo(A) :- head(A,B),tail(A,C),allgeqtwo(C),my_succ(D,B),one(E),geq(D,E)
allpositivememberone(A) :- head(A,B),one_in(B)
allpositivememberone(A) :- tail(A,B),allpositivememberone(B),head(B,C),positive(C)
sorted_decr(A) :- head(A,B),tail(A,C),head(C,B)
sorted_decr(A) :- tail(A,B),sorted_decr(B)
membertwo(A) :- head(A,B),decrement(B,C),one_in(C)
membertwo(A) :- tail(A,B),membertwo(B)
filter_negative(A,B) :- empty(A),empty(B)
filter_negative(A,B) :- cons3(A,C,D),negative(C),filter_negative(D,B)
filter_negative(A,B) :- cons3(A,C,D),filter_negative(D,E),cons(C,E,B)

 stevie time 0.5650211469910573

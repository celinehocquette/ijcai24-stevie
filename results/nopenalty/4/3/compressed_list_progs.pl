ho_1(A,B,P) :- P(A,C),P(C,D),P(D,E),P(E,F),P(F,B)
addlast5(A,B) :- ho_1(A,B,addlast1)
addhead5(A,B) :- ho_1(A,B,addhead1)
duplheadk5(A,B) :- ho_1(A,B,duplhead)
repeatminushead5(A,B) :- ho_1(A,B,minushead1)
repeatminuslast5(A,B) :- ho_1(A,B,minuslast1)
ho_5(A,P) :- empty(A)
ho_5(A,P) :- head(A,B),tail(A,C),P(B),ho_5(C,P)
allpositiveallodd(A) :- ho_5(A,odd)
allnegative(A) :- ho_5(A,negative)
allone(A) :- ho_5(A,one_in)
allzero(A) :- ho_5(A,zero_in)
ho_53(A,B,P,Q,R) :- empty(A),empty(B)
ho_53(A,B,P,Q,R) :- P(A,C),Q(A,D),P(B,E),Q(B,F),R(C,E),ho_53(D,F,P,Q,R)
maptimestwo(A,B) :- ho_53(A,B,head,tail,double)
mapcube(A,B) :- ho_53(A,B,head,tail,cube)
mapminusone(A,B) :- ho_53(A,B,head,tail,decrement)
chartoint(A,B) :- ho_53(A,B,head,tail,ord)
mapsquare(A,B) :- ho_53(A,B,head,tail,square)
inttobin(A,B) :- ho_53(A,B,head,tail,bin)
ho_59(A,B,P) :- empty(A),zero(B)
ho_59(A,B,P) :- head(A,C),tail(A,D),ho_59(D,E,P),P(C,E,B)
sum_list(A,B) :- ho_59(A,B,sum)
orlist(A,B) :- ho_59(A,B,or_element)
maxlist(A,B) :- ho_59(A,B,max)
ho_121(A,B,P,Q,R) :- P(A,B),Q(B,C),R(C)
ho_121(A,B,P,Q,R) :- P(A,C),ho_121(C,B,P,Q,R)
rotateuntilone(A,B) :- ho_121(A,B,rotate1,head,one)
decrement1until(A,B) :- ho_121(A,B,decrementhead1,head,zero_in)
dropuntileven(A,B) :- ho_121(A,B,tail,head,even)
dropuntilodd(A,B) :- ho_121(A,B,tail,head,odd)
doubleheaduntil(A,B) :- ho_121(A,B,doublehead,head,c128)
squareheaduntil(A,B) :- ho_121(A,B,squarehead,head,c256)
ho_160(A,B,P,Q,R) :- empty(A),empty(B)
ho_160(A,B,P,Q,R) :- P(A,C,D),Q(C),ho_160(D,B,P,Q,R)
ho_160(A,B,P,Q,R) :- P(A,C,D),R(C),ho_160(D,E,P,Q,R),cons(C,E,B)
filter_odd(A,B) :- ho_160(A,B,cons3,odd,even)
filter_positive(A,B) :- ho_160(A,B,cons3,positive,negative)
filter_even(A,B) :- ho_160(A,B,cons3,even,odd)
filter_zero(A,B) :- ho_160(A,B,cons3,zero_in,one_in)
ho_171(A,P,Q) :- P(A,B),Q(B)
ho_171(A,P,Q) :- tail(A,B),ho_171(B,P,Q)
memberzero(A) :- ho_171(A,head,zero_in)
memberminusone(A) :- ho_171(A,head,minusone)
memberodd(A) :- ho_171(A,head,odd)
membereven(A) :- ho_171(A,head,even)
ho_181(A,B,C,P,Q) :- zero_in(A),P(B,C)
ho_181(A,B,C,P,Q) :- decrement(A,D),ho_181(D,B,E,P,Q),Q(E,C)
iterateaddheadk(A,B,C) :- ho_181(A,B,C,eq_list,addhead1)
iterateaddlastk(A,B,C) :- ho_181(A,B,C,eq_list,addlast1)
iteratedecrementheadk(A,B,C) :- ho_181(A,B,C,eq_list,decrementhead1)
ho_242(A,B,P,Q,R) :- empty(A),P(B)
ho_242(A,B,P,Q,R) :- head(A,C),tail(A,D),Q(C),ho_242(D,B,P,Q,R)
ho_242(A,B,P,Q,R) :- head(A,C),tail(A,D),R(C),ho_242(D,E,P,Q,R),my_increment(E,B)
count_positive(A,B) :- ho_242(A,B,zero_int,negative,positive)
count_zero(A,B) :- ho_242(A,B,zero_int,one,zero_in)
count_negative(A,B) :- ho_242(A,B,zero_int,positive,negative)
count_even(A,B) :- ho_242(A,B,zero_int,odd,even)
count_one(A,B) :- ho_242(A,B,zero_int,zero_in,one)
ho_431(A,P) :- tail(A,B),empty(B)
ho_431(A,P) :- head(A,B),tail(A,C),ho_431(C,P),head(C,D),P(B,D)
sorted_triple(A) :- ho_431(A,my_triple)
sorted_double(A) :- ho_431(A,my_double)
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
alloddmemberone(A) :- head(A,B),one_in(B)
alloddmemberone(A) :- tail(A,B),alloddmemberone(B),head(B,C),odd(C)

 stevie time 12.037546040999999

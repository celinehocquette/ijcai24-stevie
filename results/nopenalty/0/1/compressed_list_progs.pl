ho_1(A,B,P) :- P(A,C),P(C,D),P(D,E),P(E,F),P(F,B)
addhead5(A,B) :- ho_1(A,B,addhead1)
addlast5(A,B) :- ho_1(A,B,addlast1)
dropfirst5(A,B) :- ho_1(A,B,tail)
repeatminuslast5(A,B) :- ho_1(A,B,minuslast1)
ho_103(A,B,P,Q,R) :- P(A),zero_int(B)
ho_103(A,B,P,Q,R) :- head(A,C),tail(A,D),Q(C),ho_103(D,B,P,Q,R)
ho_103(A,B,P,Q,R) :- head(A,C),tail(A,D),R(C),ho_103(D,E,P,Q,R),my_increment(E,B)
count_positive(A,B) :- ho_103(A,B,empty,negative,positive)
count_even(A,B) :- ho_103(A,B,empty,odd,even)
ho_142(A,B,P,Q,R) :- empty(A),empty(B)
ho_142(A,B,P,Q,R) :- P(A,C),Q(A,D),P(B,E),Q(B,F),R(C,E),ho_142(D,F,P,Q,R)
inttobin(A,B) :- ho_142(A,B,head,tail,bin)
maptimesthree(A,B) :- ho_142(A,B,head,tail,triple)
mapchangesign(A,B) :- ho_142(A,B,head,tail,changesign)
mapsquare(A,B) :- ho_142(A,B,head,tail,square)
ho_157(A,P) :- head(A,B),P(B)
ho_157(A,P) :- tail(A,B),ho_157(B,P)
memberodd(A) :- ho_157(A,odd)
memberminusone(A) :- ho_157(A,minusone)
memberone(A) :- ho_157(A,one_in)
ho_173(A,B,C,P) :- zero_in(A),eq_list(B,C)
ho_173(A,B,C,P) :- decrement(A,D),P(B,E),ho_173(D,E,C,P)
iterateaddheadk(A,B,C) :- ho_173(A,B,C,addhead1)
iteraterepeatN(A,B,C) :- ho_173(A,B,C,duplhead)
ho_346(A,B,P,Q) :- empty(A),empty(B)
ho_346(A,B,P,Q) :- cons3(A,C,D),P(C),ho_346(D,B,P,Q)
ho_346(A,B,P,Q) :- cons3(A,C,D),ho_346(D,E,P,Q),Q(C),cons(C,E,B)
filter_zero(A,B) :- ho_346(A,B,zero_in,one_in)
filter_one(A,B) :- ho_346(A,B,one_in,zero_in)
addhead5(A,B) :- addhead1(A,C),addhead1(C,D),addhead1(D,E),addhead1(E,F),addhead1(F,B)
sum_list(A,B) :- empty(A),zero(B)
sum_list(A,B) :- head(A,C),tail(A,D),sum_list(D,E),sum(C,E,B)
allpositiveallodd(A) :- empty(A)
allpositiveallodd(A) :- head(A,B),tail(A,C),positive(B),odd(B),allpositiveallodd(C)
memberthree(A) :- head(A,B),decrement(B,C),decrement(C,D),one_in(D)
memberthree(A) :- tail(A,B),memberthree(B)
addlast5(A,B) :- addlast1(A,C),addlast1(C,D),addlast1(D,E),addlast1(E,F),addlast1(F,B)
repeatminuslast5(A,B) :- minuslast1(A,C),minuslast1(C,D),minuslast1(D,E),minuslast1(E,F),minuslast1(F,B)
allpositivememberone(A) :- head(A,B),one_in(B)
allpositivememberone(A) :- tail(A,B),allpositivememberone(B),head(B,C),positive(C)
memberfour(A) :- head(A,B),decrement(B,C),decrement(C,D),decrement(D,E),one_in(E)
memberfour(A) :- tail(A,B),memberfour(B)
allnegative(A) :- empty(A)
allnegative(A) :- head(A,B),tail(A,C),negative(B),allnegative(C)
decrement1until(A,B) :- decrementhead1(A,B),head(B,C),zero_in(C)
decrement1until(A,B) :- decrementhead1(A,C),decrement1until(C,B)
iteratedecrementheadk(A,B,C) :- zero_in(A),eq_list(B,C)
iteratedecrementheadk(A,B,C) :- decrement(A,D),iteratedecrementheadk(D,B,E),decrementhead1(E,C)
iterateaddheadlastk(A,B,C) :- zero_in(A),eq_list(B,C)
iterateaddheadlastk(A,B,C) :- decrement(A,D),addhead1(B,E),addlast1(E,F),iterateaddheadlastk(D,F,C)

 stevie time 0.1010374210000009
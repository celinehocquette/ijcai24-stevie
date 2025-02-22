ho_21(A,B,P,Q) :- P(A,B),head(B,C),Q(C)
ho_21(A,B,P,Q) :- P(A,C),ho_21(C,B,P,Q)
rotateuntilone(A,B) :- ho_21(A,B,rotate1,one)
squareheaduntil(A,B) :- ho_21(A,B,squarehead,c256)
ho_25(A,P) :- empty(A)
ho_25(A,P) :- head(A,B),tail(A,C),P(B),ho_25(C,P)
allzero(A) :- ho_25(A,zero_in)
allodd(A) :- ho_25(A,odd)
ho_39(A,B,P) :- empty(A),zero(B)
ho_39(A,B,P) :- head(A,C),tail(A,D),ho_39(D,E,P),P(C,E,B)
sum_list(A,B) :- ho_39(A,B,sum)
maxlist(A,B) :- ho_39(A,B,max)
ho_64(A,P) :- tail(A,B),empty(B)
ho_64(A,P) :- head(A,B),tail(A,C),ho_64(C,P),head(C,D),P(B,D)
sorted_triple(A) :- ho_64(A,my_triple)
increment_seq(A) :- ho_64(A,incrementin)
ho_144(A,B,P) :- empty(A),empty(B)
ho_144(A,B,P) :- head(A,C),tail(A,D),head(B,E),tail(B,F),P(C,E),ho_144(D,F,P)
inttobin(A,B) :- ho_144(A,B,bin)
chartoint(A,B) :- ho_144(A,B,ord)
maptimesthree(A,B) :- ho_144(A,B,triple)
mapaddone(A,B) :- ho_144(A,B,increment)
mapcube(A,B) :- ho_144(A,B,cube)
repeatminuslast5(A,B) :- minuslast1(A,C),minuslast1(C,D),minuslast1(D,E),minuslast1(E,F),minuslast1(F,B)
iteraterepeatN(A,B,C) :- zero_in(A),eq_list(B,C)
iteraterepeatN(A,B,C) :- decrement(A,D),iteraterepeatN(D,B,E),duplhead(E,C)
allthree(A) :- empty(A)
allthree(A) :- head(A,B),tail(A,C),decrement(B,D),decrement(D,E),one_in(E),allthree(C)
allgeqthree(A) :- empty(A)
allgeqthree(A) :- head(A,B),tail(A,C),my_succ(D,B),one(E),geq(D,E),allgeqthree(C)
filter_zero(A,B) :- empty(A),empty(B)
filter_zero(A,B) :- cons3(A,C,D),zero_in(C),filter_zero(D,B)
filter_zero(A,B) :- cons3(A,C,D),one_in(C),filter_zero(D,E),cons(C,E,B)
memberodd(A) :- head(A,B),odd(B)
memberodd(A) :- tail(A,B),memberodd(B)
allgeqtwo(A) :- empty(A)
allgeqtwo(A) :- head(A,B),tail(A,C),one(D),my_succ(E,B),geq(E,D),allgeqtwo(C)
count_one(A,B) :- empty(A),zero_int(B)
count_one(A,B) :- head(A,C),tail(A,D),zero_in(C),count_one(D,B)
count_one(A,B) :- head(A,C),tail(A,D),one(C),count_one(D,E),my_increment(E,B)

 stevie time 0.1874819300001036

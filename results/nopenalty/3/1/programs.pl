dropuntilodd(A,B):- tail(A,B),head(B,C),odd(C).
dropuntilodd(A,B):- tail(A,C),dropuntilodd(C,B).
dropfirst5(A,B):- tail(A,F),tail(F,D),tail(D,E),tail(E,C),tail(C,B).
addhead5(A,B):- addhead1(A,E),addhead1(E,C),addhead1(C,F),addhead1(F,D),addhead1(D,B).
duplheadk5(A,B):- duplhead(A,D),duplhead(D,C),duplhead(C,F),duplhead(F,E),duplhead(E,B).
memberminusone(A):- head(A,B),minusone(B).
memberminusone(A):- tail(A,B),memberminusone(B).
allodd(A):- empty(A).
allodd(A):- head(A,B),tail(A,C),odd(B),allodd(C).
iterateaddheadk(A,B,C):- zero_in(A),eq_list(B,C).
iterateaddheadk(A,B,C):- decrement(A,E),addhead1(B,D),iterateaddheadk(E,D,C).
increment_seq(A):- tail(A,B),empty(B).
increment_seq(A):- head(A,B),tail(A,D),increment_seq(D),head(D,C),incrementin(B,C).
alltwo(A):- empty(A).
alltwo(A):- head(A,C),tail(A,D),decrement(C,B),one_in(B),alltwo(D).
twomembers_0_2(A):- tail(A,D),head(D,B),decrement(B,C),one(C).
twomembers_0_2(A):- tail(A,B),tail(B,C),twomembers_0_2(C).
twomembers_0_2(A):- tail(A,C),tail(C,B),tail(B,D),twomembers_0_2(D).
count_negative(A,B):- empty(A),zero_int(B).
count_negative(A,B):- head(A,C),tail(A,D),positive(C),count_negative(D,B).
count_negative(A,B):- head(A,C),tail(A,D),negative(C),count_negative(D,E),my_increment(E,B).
mapchangesign(A,B):- empty(A),empty(B).
mapchangesign(A,B):- head(A,C),tail(A,F),head(B,D),tail(B,E),changesign(C,D),mapchangesign(E,F).
mapcube(A,B):- empty(A),empty(B).
mapcube(A,B):- head(A,C),tail(A,E),head(B,D),tail(B,F),cube(C,D),mapcube(E,F).
repeatminushead5(A,B):- minushead1(A,E),minushead1(E,C),minushead1(C,F),minushead1(F,D),minushead1(D,B).
memberone(A):- head(A,B),one_in(B).
memberone(A):- tail(A,B),memberone(B).
iteraterepeatN(A,B,C):- zero_in(A),eq_list(B,C).
iteraterepeatN(A,B,C):- decrement(A,D),iteraterepeatN(D,B,E),duplhead(E,C).
allzero(A):- empty(A).
allzero(A):- head(A,B),tail(A,C),zero_in(B),allzero(C).
add1until(A,B):- addhead1(A,B),head(B,C),zero_in(C).
add1until(A,B):- addhead1(A,C),add1until(C,B).
allthree(A):- empty(A).
allthree(A):- head(A,B),tail(A,C),decrement(B,E),allthree(C),decrement(E,D),one_in(D).
sorted_triple(A):- tail(A,B),empty(B).
sorted_triple(A):- head(A,B),tail(A,C),sorted_triple(C),head(C,D),my_triple(B,D).
twomembers_0_1(A):- tail(A,C),head(C,B),zero(B).
twomembers_0_1(A):- tail(A,B),tail(B,C),twomembers_0_1(C).
twomembers_0_1(A):- head(A,B),tail(A,C),odd(B),twomembers_0_1(C).
allgeqtwo(A):- empty(A).
allgeqtwo(A):- head(A,B),tail(A,C),allgeqtwo(C),my_succ(D,B),one(E),geq(D,E).
andlist(A,B):- empty(A),one(B).
andlist(A,B):- head(A,D),tail(A,E),andlist(E,C),and_element(C,D,B).
count_positive(A,B):- empty(A),zero_int(B).
count_positive(A,B):- head(A,C),tail(A,D),negative(C),count_positive(D,B).
count_positive(A,B):- head(A,D),tail(A,E),positive(D),count_positive(E,C),my_increment(C,B).
maxlist(A,B):- empty(A),one(B).
maxlist(A,B):- head(A,D),tail(A,E),maxlist(E,C),max(C,D,B).
mapaddone(A,B):- empty(A),empty(B).
mapaddone(A,B):- head(A,D),tail(A,E),head(B,C),tail(B,F),increment(D,C),mapaddone(E,F).
chartoint(A,B):- empty(A),empty(B).
chartoint(A,B):- head(A,E),tail(A,F),head(B,C),tail(B,D),ord(E,C),chartoint(F,D).
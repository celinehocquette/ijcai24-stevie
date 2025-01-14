repeatminuslast5(A,B):- minuslast1(A,D),minuslast1(D,C),minuslast1(C,E),minuslast1(E,F),minuslast1(F,B).
iteraterepeatN(A,B,C):- zero_in(A),eq_list(B,C).
iteraterepeatN(A,B,C):- decrement(A,D),iteraterepeatN(D,B,E),duplhead(E,C).
rotateuntilone(A,B):- rotate1(A,B),head(B,C),one(C).
rotateuntilone(A,B):- rotate1(A,C),rotateuntilone(C,B).
allzero(A):- empty(A).
allzero(A):- head(A,B),tail(A,C),zero_in(B),allzero(C).
sum_list(A,B):- empty(A),zero(B).
sum_list(A,B):- head(A,C),tail(A,D),sum_list(D,E),sum(C,E,B).
sorted_triple(A):- tail(A,B),empty(B).
sorted_triple(A):- head(A,C),tail(A,D),sorted_triple(D),head(D,B),my_triple(C,B).
allthree(A):- empty(A).
allthree(A):- head(A,D),tail(A,E),decrement(D,C),decrement(C,B),one_in(B),allthree(E).
allgeqthree(A):- empty(A).
allgeqthree(A):- head(A,C),tail(A,E),my_succ(B,C),one(D),geq(B,D),allgeqthree(E).
inttobin(A,B):- empty(A),empty(B).
inttobin(A,B):- head(A,D),tail(A,E),head(B,C),tail(B,F),bin(D,C),inttobin(E,F).
chartoint(A,B):- empty(A),empty(B).
chartoint(A,B):- head(A,C),tail(A,D),head(B,E),tail(B,F),ord(C,E),chartoint(D,F).
filter_zero(A,B):- empty(A),empty(B).
filter_zero(A,B):- cons3(A,C,D),zero_in(C),filter_zero(D,B).
filter_zero(A,B):- cons3(A,D,E),one_in(D),filter_zero(E,C),cons(D,C,B).
squareheaduntil(A,B):- squarehead(A,B),head(B,C),c256(C).
squareheaduntil(A,B):- squarehead(A,C),squareheaduntil(C,B).
memberodd(A):- head(A,B),odd(B).
memberodd(A):- tail(A,B),memberodd(B).
allodd(A):- empty(A).
allodd(A):- head(A,B),tail(A,C),odd(B),allodd(C).
increment_seq(A):- tail(A,B),empty(B).
increment_seq(A):- head(A,C),tail(A,D),increment_seq(D),head(D,B),incrementin(C,B).
allgeqtwo(A):- empty(A).
allgeqtwo(A):- head(A,D),tail(A,E),one(B),my_succ(C,D),geq(C,B),allgeqtwo(E).
maxlist(A,B):- empty(A),zero(B).
maxlist(A,B):- head(A,C),tail(A,E),maxlist(E,D),max(C,D,B).
count_one(A,B):- empty(A),zero_int(B).
count_one(A,B):- head(A,C),tail(A,D),zero_in(C),count_one(D,B).
count_one(A,B):- head(A,C),tail(A,D),one(C),count_one(D,E),my_increment(E,B).
maptimesthree(A,B):- empty(A),empty(B).
maptimesthree(A,B):- head(A,D),tail(A,F),head(B,C),tail(B,E),triple(D,C),maptimesthree(F,E).
mapaddone(A,B):- empty(A),empty(B).
mapaddone(A,B):- head(A,D),tail(A,F),head(B,C),tail(B,E),increment(D,C),mapaddone(F,E).
mapcube(A,B):- empty(A),empty(B).
mapcube(A,B):- head(A,E),tail(A,F),head(B,C),tail(B,D),cube(E,C),mapcube(F,D).
dropuntilodd(A,B):- tail(A,B),head(B,C),odd(C).
dropuntilodd(A,B):- tail(A,C),dropuntilodd(C,B).
doubleheaduntil(A,B):- doublehead(A,B),head(B,C),c128(C).
doubleheaduntil(A,B):- doublehead(A,C),doubleheaduntil(C,B).
dropuntilthree(A,B):- tail(A,B),head(B,D),decrement(D,C),decrement(C,E),one_in(E).
dropuntilthree(A,B):- tail(A,C),dropuntilthree(C,B).
allnegative(A):- empty(A).
allnegative(A):- head(A,B),tail(A,C),negative(B),allnegative(C).
iteratedropk(A,B,C):- zero_in(A),eq_list(B,C).
iteratedropk(A,B,C):- decrement(A,E),tail(B,D),iteratedropk(E,D,C).
memberfive(A):- head(A,F),decrement(F,E),decrement(E,C),decrement(C,D),decrement(D,B),one_in(B).
memberfive(A):- tail(A,B),memberfive(B).
andlist(A,B):- empty(A),one(B).
andlist(A,B):- head(A,C),tail(A,E),andlist(E,D),and_element(C,D,B).
count_odd(A,B):- empty(A),zero_int(B).
count_odd(A,B):- head(A,C),tail(A,D),even(C),count_odd(D,B).
count_odd(A,B):- head(A,D),tail(A,E),odd(D),count_odd(E,C),my_increment(C,B).
dropfirst5(A,B):- tail(A,C),tail(C,F),tail(F,D),tail(D,E),tail(E,B).
memberone(A):- head(A,B),one_in(B).
memberone(A):- tail(A,B),memberone(B).
memberfour(A):- head(A,E),decrement(E,B),decrement(B,D),decrement(D,C),one_in(C).
memberfour(A):- tail(A,B),memberfour(B).
membertwo(A):- head(A,B),decrement(B,C),one_in(C).
membertwo(A):- tail(A,B),membertwo(B).
iteratedecrementheadk(A,B,C):- zero_in(A),eq_list(B,C).
iteratedecrementheadk(A,B,C):- decrement(A,D),iteratedecrementheadk(D,B,E),decrementhead1(E,C).
allevenmemberzero(A):- head(A,C),tail(A,D),zero_in(C),head(D,B),even(B).
allevenmemberzero(A):- head(A,B),tail(A,C),even(B),allevenmemberzero(C).
orlist(A,B):- empty(A),zero(B).
orlist(A,B):- head(A,D),tail(A,E),orlist(E,C),or_element(C,D,B).
count_zero(A,B):- empty(A),zero_int(B).
count_zero(A,B):- head(A,C),tail(A,D),one(C),count_zero(D,B).
count_zero(A,B):- head(A,D),tail(A,E),zero_in(D),count_zero(E,C),my_increment(C,B).
filter_negative(A,B):- empty(A),empty(B).
filter_negative(A,B):- cons3(A,C,D),negative(C),filter_negative(D,B).
filter_negative(A,B):- cons3(A,E,C),filter_negative(C,D),positive(E),cons(E,D,B).
count_positive(A,B):- empty(A),zero_int(B).
count_positive(A,B):- head(A,C),tail(A,D),negative(C),count_positive(D,B).
count_positive(A,B):- head(A,D),tail(A,E),positive(D),count_positive(E,C),my_increment(C,B).
mapminusone(A,B):- tail(A,C),tail(B,C).
mapminusone(A,B):- tail(A,E),tail(B,F),head(E,D),decrement(D,C),mapminusone(E,F),head(F,C).
filter_one(A,B):- empty(A),empty(B).
filter_one(A,B):- cons3(A,C,D),one_in(C),filter_one(D,B).
filter_one(A,B):- cons3(A,D,E),zero_in(D),filter_one(E,C),cons(D,C,B).
filter_even(A,B):- empty(A),empty(B).
filter_even(A,B):- cons3(A,C,E),odd(C),filter_even(E,D),cons(C,D,B).
filter_even(A,B):- cons3(A,D,C),even(D),cons(D,C,A),filter_even(C,B).
duplheadk5(A,B):- duplhead(A,D),duplhead(D,F),duplhead(F,E),duplhead(E,C),duplhead(C,B).
membereven(A):- head(A,B),even(B).
membereven(A):- tail(A,B),membereven(B).
memberminusone(A):- head(A,B),minusone(B).
memberminusone(A):- tail(A,B),memberminusone(B).
iterateaddheadk(A,B,C):- zero_in(A),eq_list(B,C).
iterateaddheadk(A,B,C):- decrement(A,D),iterateaddheadk(D,B,E),addhead1(E,C).
minlist(A,B):- empty(A),c100(B).
minlist(A,B):- head(A,C),tail(A,E),minlist(E,D),min(C,D,B).

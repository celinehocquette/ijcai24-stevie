allpositiveallodd(A):- empty(A).
allpositiveallodd(A):- head(A,B),tail(A,C),odd(B),allpositiveallodd(C).
alltwo(A):- empty(A).
alltwo(A):- head(A,C),tail(A,D),decrement(C,B),one_in(B),alltwo(D).
addlast5(A,B):- addlast1(A,F),addlast1(F,C),addlast1(C,E),addlast1(E,D),addlast1(D,B).
maptimestwo(A,B):- empty(A),empty(B).
maptimestwo(A,B):- head(A,E),tail(A,F),head(B,C),tail(B,D),double(E,C),maptimestwo(F,D).
sum_list(A,B):- empty(A),zero(B).
sum_list(A,B):- head(A,C),tail(A,D),sum_list(D,E),sum(C,E,B).
addhead5(A,B):- addhead1(A,F),addhead1(F,E),addhead1(E,D),addhead1(D,C),addhead1(C,B).
mapcube(A,B):- empty(A),empty(B).
mapcube(A,B):- head(A,C),tail(A,D),head(B,E),tail(B,F),cube(C,E),mapcube(D,F).
dropuntilthree(A,B):- tail(A,B),head(B,E),decrement(E,D),decrement(D,C),one_in(C).
dropuntilthree(A,B):- tail(A,C),dropuntilthree(C,B).
duplheadk5(A,B):- duplhead(A,D),duplhead(D,E),duplhead(E,C),duplhead(C,F),duplhead(F,B).
allnegative(A):- empty(A).
allnegative(A):- head(A,B),tail(A,C),negative(B),allnegative(C).
allone(A):- empty(A).
allone(A):- head(A,B),tail(A,C),one_in(B),allone(C).
rotateuntilone(A,B):- rotate1(A,B),head(B,C),one(C).
rotateuntilone(A,B):- rotate1(A,C),rotateuntilone(C,B).
iteratedropk(A,B,C):- zero_in(A),eq_list(B,C).
iteratedropk(A,B,C):- decrement(A,E),tail(B,D),iteratedropk(E,D,C).
filter_odd(A,B):- empty(A),empty(B).
filter_odd(A,B):- cons3(A,D,C),odd(D),filter_odd(C,B).
filter_odd(A,B):- cons3(A,D,E),even(D),filter_odd(E,C),cons(D,C,B).
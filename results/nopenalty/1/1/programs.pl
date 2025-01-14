dropuntileven(A,B):- tail(A,B),head(B,C),even(C).
dropuntileven(A,B):- tail(A,C),dropuntileven(C,B).
doubleheaduntil(A,B):- doublehead(A,B),head(B,C),c128(C).
doubleheaduntil(A,B):- doublehead(A,C),doubleheaduntil(C,B).
duplheadk5(A,B):- duplhead(A,C),duplhead(C,D),duplhead(D,F),duplhead(F,E),duplhead(E,B).
squareheaduntil(A,B):- squarehead(A,B),head(B,C),c256(C).
squareheaduntil(A,B):- squarehead(A,C),squareheaduntil(C,B).
allone(A):- empty(A).
allone(A):- head(A,B),tail(A,C),one_in(B),allone(C).
allzero(A):- empty(A).
allzero(A):- head(A,B),tail(A,C),zero_in(B),allzero(C).
allpositivememberone(A):- head(A,B),one_in(B).
allpositivememberone(A):- tail(A,B),allpositivememberone(B),head(B,C),positive(C).
iteratedecrementheadk(A,B,C):- zero_in(A),eq_list(B,C).
iteratedecrementheadk(A,B,C):- decrement(A,E),decrementhead1(B,D),iteratedecrementheadk(E,D,C).
memberfour(A):- head(A,B),decrement(B,E),decrement(E,D),decrement(D,C),one_in(C).
memberfour(A):- tail(A,B),memberfour(B).
decrement1until(A,B):- decrementhead1(A,B),head(B,C),zero_in(C).
decrement1until(A,B):- decrementhead1(A,C),decrement1until(C,B).
allpositive(A):- empty(A).
allpositive(A):- head(A,B),tail(A,C),positive(B),allpositive(C).
allpositiveallodd(A):- head(A,B),tail(A,D),odd(B),head(D,C),positive(C),odd(C).
twomembers_0_1(A):- tail(A,B),head(B,C),one(C).
twomembers_0_1(A):- tail(A,C),tail(C,B),twomembers_0_1(B).
twomembers_0_1(A):- head(A,B),tail(A,C),zero(B),twomembers_0_1(C).
mapcube(A,B):- empty(A),empty(B).
mapcube(A,B):- head(A,C),tail(A,E),head(B,D),tail(B,F),cube(C,D),mapcube(E,F).
memberzero(A):- head(A,B),zero_in(B).
memberzero(A):- tail(A,B),memberzero(B).
iteraterepeatN(A,B,C):- zero_in(A),eq_list(B,C).
iteraterepeatN(A,B,C):- decrement(A,D),iteraterepeatN(D,B,E),duplhead(E,C).
rotateuntilone(A,B):- rotate1(A,B),head(B,C),one(C).
rotateuntilone(A,B):- rotate1(A,C),rotateuntilone(C,B).
dropuntilthree(A,B):- tail(A,B),head(B,D),decrement(D,C),decrement(C,E),one_in(E).
dropuntilthree(A,B):- tail(A,C),dropuntilthree(C,B).
allevenmemberzero(A):- tail(A,B),tail(B,D),head(D,C),zero_in(C).
allevenmemberzero(A):- head(A,B),tail(A,C),even(B),allevenmemberzero(C).
iterateaddlastk(A,B,C):- zero_in(A),eq_list(B,C).
iterateaddlastk(A,B,C):- decrement(A,D),iterateaddlastk(D,B,E),addlast1(E,C).
sum_list(A,B):- empty(A),zero(B).
sum_list(A,B):- head(A,D),tail(A,E),sum_list(E,C),sum(C,D,B).
iterateaddheadlastk(A,B,C):- zero_in(A),eq_list(B,C).
iterateaddheadlastk(A,B,C):- decrement(A,E),addhead1(B,F),addlast1(F,D),iterateaddheadlastk(E,D,C).
count_even(A,B):- empty(A),zero_int(B).
count_even(A,B):- head(A,C),tail(A,D),odd(C),count_even(D,B).
count_even(A,B):- head(A,C),tail(A,D),even(C),count_even(D,E),my_increment(E,B).
count_negative(A,B):- empty(A),zero_int(B).
count_negative(A,B):- head(A,C),tail(A,D),positive(C),count_negative(D,B).
count_negative(A,B):- head(A,C),tail(A,D),negative(C),count_negative(D,E),my_increment(E,B).
mapminusone(A,B):- empty(A),empty(B).
mapminusone(A,B):- head(A,E),tail(A,F),head(B,C),tail(B,D),decrement(E,C),mapminusone(F,D).
mapaddone(A,B):- empty(A),empty(B).
mapaddone(A,B):- head(A,D),tail(A,F),head(B,C),tail(B,E),increment(D,C),mapaddone(F,E).

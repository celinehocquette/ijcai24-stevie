memberodd(A):- head(A,B),odd(B).
memberodd(A):- tail(A,B),memberodd(B).
memberzero(A):- head(A,B),zero_in(B).
memberzero(A):- tail(A,B),memberzero(B).
allpositivememberone(A):- head(A,B),one_in(B).
allpositivememberone(A):- tail(A,C),allpositivememberone(C),head(C,B),positive(B).
allzero(A):- empty(A).
allzero(A):- head(A,B),tail(A,C),zero_in(B),allzero(C).
iteraterepeatN(A,B,C):- zero_in(A),eq_list(B,C).
iteraterepeatN(A,B,C):- decrement(A,E),iteraterepeatN(E,B,D),duplhead(D,C).
memberfour(A):- head(A,C),decrement(C,E),decrement(E,B),decrement(B,D),one_in(D).
memberfour(A):- tail(A,B),memberfour(B).
add1until(A,B):- addhead1(A,B),head(B,C),zero_in(C).
add1until(A,B):- addhead1(A,C),add1until(C,B).
allpositiveallodd(A):- empty(A).
allpositiveallodd(A):- head(A,B),tail(A,C),positive(B),odd(B),allpositiveallodd(C).
count_zero(A,B):- empty(A),zero_int(B).
count_zero(A,B):- head(A,C),tail(A,D),one(C),count_zero(D,B).
count_zero(A,B):- head(A,C),tail(A,E),zero_in(C),count_zero(E,D),my_increment(D,B).
mapaddone(A,B):- empty(A),empty(B).
mapaddone(A,B):- head(A,C),tail(A,F),head(B,D),tail(B,E),increment(C,D),mapaddone(F,E).
filter_negative(A,B):- empty(A),empty(B).
filter_negative(A,B):- cons3(A,C,D),negative(C),filter_negative(D,B).
filter_negative(A,B):- cons3(A,E,D),filter_negative(D,C),positive(E),cons(E,C,B).
allevenmemberzero(A):- tail(A,B),empty(B).
allevenmemberzero(A):- tail(A,C),allevenmemberzero(C),head(C,B),zero_in(B).
allevenmemberzero(A):- head(A,B),tail(A,C),zero_in(B),allevenmemberzero(C).
allevenmemberzero(A):- head(A,B),tail(A,C),even(B),tail(C,D),allevenmemberzero(D).
dropuntileven(A,B):- tail(A,B),head(B,C),even(C).
dropuntileven(A,B):- tail(A,C),dropuntileven(C,B).
squareheaduntil(A,B):- squarehead(A,B),head(B,C),c256(C).
squareheaduntil(A,B):- squarehead(A,C),squareheaduntil(C,B).
decrement1until(A,B):- decrementhead1(A,B),head(B,C),zero_in(C).
decrement1until(A,B):- decrementhead1(A,C),decrement1until(C,B).
iterateaddlastk(A,B,C):- zero_in(A),eq_list(B,C).
iterateaddlastk(A,B,C):- decrement(A,E),addlast1(B,D),iterateaddlastk(E,D,C).
allpositive(A):- empty(A).
allpositive(A):- head(A,B),tail(A,C),positive(B),allpositive(C).
sorted_triple(A):- tail(A,B),empty(B).
sorted_triple(A):- head(A,B),tail(A,D),sorted_triple(D),head(D,C),my_triple(B,C).
multlist(A,B):- empty(A),one(B).
multlist(A,B):- head(A,C),tail(A,D),multlist(D,E),mult(C,E,B).
count_positive(A,B):- empty(A),zero_int(B).
count_positive(A,B):- head(A,C),tail(A,D),negative(C),count_positive(D,B).
count_positive(A,B):- head(A,C),tail(A,E),positive(C),count_positive(E,D),my_increment(D,B).
count_odd(A,B):- empty(A),zero_int(B).
count_odd(A,B):- head(A,C),tail(A,D),even(C),count_odd(D,B).
count_odd(A,B):- head(A,C),tail(A,E),odd(C),count_odd(E,D),my_increment(D,B).
maptimesthree(A,B):- empty(A),empty(B).
maptimesthree(A,B):- head(A,D),tail(A,F),head(B,C),tail(B,E),triple(D,C),maptimesthree(F,E).
filter_even(A,B):- empty(A),empty(B).
filter_even(A,B):- cons3(A,C,D),even(C),filter_even(D,B).
filter_even(A,B):- cons3(A,C,E),odd(C),filter_even(E,D),cons(C,D,B).
maptimestwo(A,B):- tail(A,C),tail(B,C).
maptimestwo(A,B):- tail(A,C),tail(B,E),maptimestwo(C,E),head(C,F),head(E,D),double(F,D).
mapsquare(A,B):- empty(A),empty(B).
mapsquare(A,B):- head(A,E),tail(A,F),head(B,C),tail(B,D),square(E,C),mapsquare(F,D).
filter_positive(A,B):- empty(A),empty(B).
filter_positive(A,B):- cons3(A,C,D),positive(C),filter_positive(D,B).
filter_positive(A,B):- cons3(A,D,C),negative(D),filter_positive(C,E),cons(D,E,B).
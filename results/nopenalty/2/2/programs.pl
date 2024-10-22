memberzero(A):- head(A,B),zero_in(B).
memberzero(A):- tail(A,B),memberzero(B).
rotateuntilone(A,B):- rotate1(A,B),head(B,C),one(C).
rotateuntilone(A,B):- rotate1(A,C),rotateuntilone(C,B).
allevenmemberzero(A):- head(A,B),zero_in(B).
allevenmemberzero(A):- tail(A,B),allevenmemberzero(B),head(B,C),even(C).
iterateaddheadk(A,B,C):- zero_in(A),eq_list(B,C).
iterateaddheadk(A,B,C):- decrement(A,E),iterateaddheadk(E,B,D),addhead1(D,C).
allnegative(A):- empty(A).
allnegative(A):- head(A,B),tail(A,C),negative(B),allnegative(C).
add1until(A,B):- addhead1(A,B),head(B,C),zero_in(C).
add1until(A,B):- addhead1(A,C),add1until(C,B).
iteratedropk(A,B,C):- zero_in(A),eq_list(B,C).
iteratedropk(A,B,C):- decrement(A,D),iteratedropk(D,B,E),tail(E,C).
alltwo(A):- empty(A).
alltwo(A):- head(A,C),tail(A,D),decrement(C,B),one_in(B),alltwo(D).
memberfive(A):- head(A,F),decrement(F,D),decrement(D,E),decrement(E,C),decrement(C,B),one_in(B).
memberfive(A):- tail(A,B),memberfive(B).
allgeqtwo(A):- empty(A).
allgeqtwo(A):- head(A,D),tail(A,E),one(B),my_succ(C,D),geq(C,B),allgeqtwo(E).
count_zero(A,B):- empty(A),zero_int(B).
count_zero(A,B):- head(A,C),tail(A,D),one(C),count_zero(D,B).
count_zero(A,B):- head(A,C),tail(A,E),zero_in(C),count_zero(E,D),my_increment(D,B).
count_odd(A,B):- empty(A),zero_int(B).
count_odd(A,B):- head(A,C),tail(A,D),even(C),count_odd(D,B).
count_odd(A,B):- head(A,C),tail(A,D),odd(C),count_odd(D,E),my_increment(E,B).
filter_even(A,B):- empty(A),empty(B).
filter_even(A,B):- cons3(A,C,D),even(C),filter_even(D,B).
filter_even(A,B):- cons3(A,D,C),filter_even(C,E),odd(D),cons(D,E,B).
filter_one(A,B):- empty(A),empty(B).
filter_one(A,B):- cons3(A,D,C),one_in(D),filter_one(C,B).
filter_one(A,B):- cons3(A,E,D),zero_in(E),filter_one(D,C),cons(E,C,B).
chartoint(A,B):- empty(A),empty(B).
chartoint(A,B):- head(A,E),tail(A,F),head(B,C),tail(B,D),ord(E,C),chartoint(F,D).
filter_positive(A,B):- empty(A),empty(B).
filter_positive(A,B):- cons3(A,C,D),positive(C),filter_positive(D,B).
filter_positive(A,B):- cons3(A,E,C),negative(E),filter_positive(C,D),cons(E,D,B).
maxlist(A,B):- empty(A),zero(B).
maxlist(A,B):- head(A,C),tail(A,E),maxlist(E,D),max(C,D,B).
mapminusone(A,B):- empty(A),empty(B).
mapminusone(A,B):- head(A,C),tail(A,F),head(B,D),tail(B,E),decrement(C,D),mapminusone(F,E).
mapchangesign(A,B):- empty(A),empty(B).
mapchangesign(A,B):- head(A,C),tail(A,D),head(B,E),tail(B,F),changesign(E,C),mapchangesign(F,D).
minlist(A,B):- empty(A),c100(B).
minlist(A,B):- head(A,C),tail(A,E),minlist(E,D),min(C,D,B).
duplheadk5(A,B):- duplhead(A,F),duplhead(F,C),duplhead(C,D),duplhead(D,E),duplhead(E,B).
addlast5(A,B):- addlast1(A,E),addlast1(E,D),addlast1(D,F),addlast1(F,C),addlast1(C,B).
addhead5(A,B):- addhead1(A,C),addhead1(C,F),addhead1(F,D),addhead1(D,E),addhead1(E,B).
squareheaduntil(A,B):- squarehead(A,B),head(B,C),c256(C).
squareheaduntil(A,B):- squarehead(A,C),squareheaduntil(C,B).
iteratedecrementheadk(A,B,C):- zero_in(A),eq_list(B,C).
iteratedecrementheadk(A,B,C):- decrement(A,E),decrementhead1(B,D),iteratedecrementheadk(E,D,C).
decrement1until(A,B):- decrementhead1(A,B),head(B,C),zero_in(C).
decrement1until(A,B):- decrementhead1(A,C),decrement1until(C,B).
sorted_triple(A):- tail(A,B),empty(B).
sorted_triple(A):- head(A,B),tail(A,D),sorted_triple(D),head(D,C),my_triple(B,C).
sorted_decr(A):- tail(A,B),empty(B).
sorted_decr(A):- head(A,C),tail(A,D),sorted_decr(D),head(D,B),geq(C,B).
count_one(A,B):- empty(A),zero_int(B).
count_one(A,B):- head(A,C),tail(A,D),zero_in(C),count_one(D,B).
count_one(A,B):- head(A,C),tail(A,D),one(C),count_one(D,E),my_increment(E,B).
count_positive(A,B):- empty(A),zero_int(B).
count_positive(A,B):- head(A,C),tail(A,D),negative(C),count_positive(D,B).
count_positive(A,B):- head(A,C),tail(A,E),positive(C),count_positive(E,D),my_increment(D,B).
mapsquare(A,B):- empty(A),empty(B).
mapsquare(A,B):- head(A,E),tail(A,F),head(B,C),tail(B,D),square(E,C),mapsquare(F,D).

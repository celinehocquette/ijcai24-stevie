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
dropfirst5(A,B):- tail(A,E),tail(E,C),tail(C,F),tail(F,D),tail(D,B).
dropuntileven(A,B):- tail(A,B),head(B,C),even(C).
dropuntileven(A,B):- tail(A,C),dropuntileven(C,B).
increment_seq(A):- tail(A,B),empty(B).
increment_seq(A):- head(A,B),tail(A,D),increment_seq(D),head(D,C),incrementin(B,C).
memberfour(A):- head(A,E),decrement(E,B),decrement(B,C),decrement(C,D),one_in(D).
memberfour(A):- tail(A,B),memberfour(B).
membertwo(A):- head(A,C),decrement(C,B),one_in(B).
membertwo(A):- tail(A,B),membertwo(B).
decrement_seq(A):- tail(A,B),empty(B).
decrement_seq(A):- head(A,C),tail(A,D),decrement_seq(D),head(D,B),decrementin(C,B).
memberthree(A):- head(A,C),decrement(C,B),decrement(B,D),one_in(D).
memberthree(A):- tail(A,B),memberthree(B).
sorted_decr(A):- tail(A,B),empty(B).
sorted_decr(A):- head(A,B),tail(A,C),sorted_decr(C),head(C,D),geq(B,D).
allthree(A):- empty(A).
allthree(A):- head(A,B),tail(A,C),decrement(B,E),allthree(C),decrement(E,D),one_in(D).
multlist(A,B):- empty(A),one(B).
multlist(A,B):- head(A,C),tail(A,D),multlist(D,E),mult(C,E,B).
count_zero(A,B):- empty(A),zero_int(B).
count_zero(A,B):- head(A,C),tail(A,D),one(C),count_zero(D,B).
count_zero(A,B):- head(A,D),tail(A,E),zero_in(D),count_zero(E,C),my_increment(C,B).
count_odd(A,B):- empty(A),zero_int(B).
count_odd(A,B):- head(A,C),tail(A,D),even(C),count_odd(D,B).
count_odd(A,B):- head(A,C),tail(A,D),odd(C),count_odd(D,E),my_increment(E,B).
mapaddone(A,B):- empty(A),empty(B).
mapaddone(A,B):- head(A,E),tail(A,F),head(B,C),tail(B,D),increment(E,C),mapaddone(F,D).
filter_odd(A,B):- empty(A),empty(B).
filter_odd(A,B):- cons3(A,C,D),odd(C),filter_odd(D,B).
filter_odd(A,B):- cons3(A,D,C),even(D),filter_odd(C,E),cons(D,E,B).
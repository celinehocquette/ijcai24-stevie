ho_142(A,B,P) :- empty(A),empty(B)
ho_142(A,B,P) :- head(A,C),tail(A,D),head(B,E),tail(B,F),P(C,E),ho_142(D,F,P)
inttobin(A,B) :- ho_142(A,B,bin)
chartoint(A,B) :- ho_142(A,B,ord)
repeatminuslast5(A,B) :- minuslast1(A,C),minuslast1(C,D),minuslast1(D,E),minuslast1(E,F),minuslast1(F,B)
iteraterepeatN(A,B,C) :- zero_in(A),eq_list(B,C)
iteraterepeatN(A,B,C) :- decrement(A,D),iteraterepeatN(D,B,E),duplhead(E,C)
rotateuntilone(A,B) :- rotate1(A,B),head(B,C),one(C)
rotateuntilone(A,B) :- rotate1(A,C),rotateuntilone(C,B)
allzero(A) :- empty(A)
allzero(A) :- head(A,B),tail(A,C),zero_in(B),allzero(C)
sum_list(A,B) :- empty(A),zero(B)
sum_list(A,B) :- head(A,C),tail(A,D),sum_list(D,E),sum(C,E,B)
sorted_triple(A) :- tail(A,B),empty(B)
sorted_triple(A) :- head(A,B),tail(A,C),sorted_triple(C),head(C,D),my_triple(B,D)
allthree(A) :- empty(A)
allthree(A) :- head(A,B),tail(A,C),decrement(B,D),decrement(D,E),one_in(E),allthree(C)
allgeqthree(A) :- empty(A)
allgeqthree(A) :- head(A,B),tail(A,C),my_succ(D,B),one(E),geq(D,E),allgeqthree(C)
filter_zero(A,B) :- empty(A),empty(B)
filter_zero(A,B) :- cons3(A,C,D),zero_in(C),filter_zero(D,B)
filter_zero(A,B) :- cons3(A,C,D),one_in(C),filter_zero(D,E),cons(C,E,B)

 stevie time 0.07903295000005528

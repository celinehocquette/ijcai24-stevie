ho_499(A,B,C,P) :- zero_in(A),eq_list(B,C)
ho_499(A,B,C,P) :- decrement(A,D),ho_499(D,B,E,P),P(E,C)
ho_145(A,B,P,Q) :- empty(A),zero_int(B)
ho_145(A,B,P,Q) :- head(A,C),tail(A,D),P(C),ho_145(D,B,P,Q)
ho_145(A,B,P,Q) :- head(A,C),tail(A,D),Q(C),ho_145(D,E,P,Q),my_increment(E,B)
ho_272(A,B,P,Q) :- empty(A),empty(B)
ho_272(A,B,P,Q) :- cons3(A,C,D),P(C),ho_272(D,B,P,Q)
ho_272(A,B,P,Q) :- cons3(A,C,D),Q(C),ho_272(D,E,P,Q),cons(C,E,B)
ho_10(A,P) :- tail(A,B),empty(B)
ho_10(A,P) :- head(A,B),tail(A,C),ho_10(C,P),head(C,D),P(B,D)
ho_290(A,P) :- head(A,B),P(B)
ho_290(A,P) :- tail(A,B),ho_290(B,P)
ho_251(A,B,P) :- empty(A),empty(B)
ho_251(A,B,P) :- head(A,C),tail(A,D),head(B,E),tail(B,F),P(C,E),ho_251(D,F,P)
ho_116(A,B,P,Q) :- empty(A),P(B)
ho_116(A,B,P,Q) :- head(A,C),tail(A,D),ho_116(D,E,P,Q),Q(C,E,B)
ho_5(A,B,P,Q) :- P(A,B),head(B,C),Q(C)
ho_5(A,B,P,Q) :- P(A,C),ho_5(C,B,P,Q)
ho_383(A,B,P,Q) :- empty(A),P(B)
ho_383(A,B,P,Q) :- head(A,C),tail(A,D),ho_383(D,E,P,Q),Q(E,C,B)
ho_319(A,P) :- empty(A)
ho_319(A,P) :- head(A,B),tail(A,C),P(B),ho_319(C,P)
ho_1(A,B,P) :- P(A,C),P(C,D),P(D,E),P(E,F),P(F,B)
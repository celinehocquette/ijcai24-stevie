ho_163(A,B,P) :- empty(A),empty(B)
ho_163(A,B,P) :- head(A,C),tail(A,D),head(B,E),tail(B,F),P(C,E),ho_163(D,F,P)
ho_39(A,B,C,P) :- zero_in(A),eq_list(B,C)
ho_39(A,B,C,P) :- decrement(A,D),ho_39(D,B,E,P),P(E,C)
ho_116(A,B,P,Q) :- empty(A),zero_int(B)
ho_116(A,B,P,Q) :- head(A,C),tail(A,D),P(C),ho_116(D,B,P,Q)
ho_116(A,B,P,Q) :- head(A,C),tail(A,D),Q(C),ho_116(D,E,P,Q),my_increment(E,B)
ho_188(A,B,P,Q) :- empty(A),empty(B)
ho_188(A,B,P,Q) :- cons3(A,C,D),P(C),ho_188(D,B,P,Q)
ho_188(A,B,P,Q) :- cons3(A,C,D),ho_188(D,E,P,Q),Q(C),cons(C,E,B)
ho_1(A,P) :- head(A,B),P(B)
ho_1(A,P) :- tail(A,B),ho_1(B,P)
ho_27(A,P) :- empty(A)
ho_27(A,P) :- head(A,B),tail(A,C),P(B),ho_27(C,P)
ho_71(A,B,P,Q) :- P(A,B),head(B,C),Q(C)
ho_71(A,B,P,Q) :- P(A,C),ho_71(C,B,P,Q)

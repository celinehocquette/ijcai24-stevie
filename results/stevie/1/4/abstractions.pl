ho_61(A,B,P) :- empty(A),empty(B)
ho_61(A,B,P) :- head(A,C),tail(A,D),head(B,E),tail(B,F),P(C,E),ho_61(D,F,P)
ho_153(A,P) :- empty(A)
ho_153(A,P) :- head(A,B),tail(A,C),P(B),ho_153(C,P)
ho_186(A,P) :- tail(A,B),empty(B)
ho_186(A,P) :- head(A,B),tail(A,C),ho_186(C,P),head(C,D),P(B,D)
ho_1(A,B,P) :- P(A,C),P(C,D),P(D,E),P(E,F),P(F,B)
ho_511(A,B,P,Q) :- empty(A),P(B)
ho_511(A,B,P,Q) :- head(A,C),tail(A,D),ho_511(D,E,P,Q),Q(C,E,B)
ho_234(A,B,C,P) :- zero_in(A),eq_list(B,C)
ho_234(A,B,C,P) :- decrement(A,D),ho_234(D,B,E,P),P(E,C)
ho_14(A,P) :- head(A,B),P(B)
ho_14(A,P) :- tail(A,B),ho_14(B,P)
ho_102(A,B,P,Q) :- empty(A),empty(B)
ho_102(A,B,P,Q) :- cons3(A,C,D),P(C),ho_102(D,B,P,Q)
ho_102(A,B,P,Q) :- cons3(A,C,D),Q(C),ho_102(D,E,P,Q),cons(C,E,B)
ho_5(A,B,P,Q) :- P(A,B),head(B,C),Q(C)
ho_5(A,B,P,Q) :- P(A,C),ho_5(C,B,P,Q)
ho_24(A,B,C,P) :- zero_in(A),eq_list(B,C)
ho_24(A,B,C,P) :- decrement(A,D),P(B,E),ho_24(D,E,C,P)
ho_44(A,B,P,Q) :- empty(A),P(B)
ho_44(A,B,P,Q) :- head(A,C),tail(A,D),ho_44(D,E,P,Q),Q(E,C,B)
ho_316(A,B,P,Q) :- empty(A),zero_int(B)
ho_316(A,B,P,Q) :- head(A,C),tail(A,D),P(C),ho_316(D,B,P,Q)
ho_316(A,B,P,Q) :- head(A,C),tail(A,D),Q(C),ho_316(D,E,P,Q),my_increment(E,B)

ho_62(A,B,P) :- empty(A),empty(B)
ho_62(A,B,P) :- head(A,C),tail(A,D),head(B,E),tail(B,F),P(C,E),ho_62(D,F,P)
ho_5(A,B,P,Q) :- P(A,B),head(B,C),Q(C)
ho_5(A,B,P,Q) :- P(A,C),ho_5(C,B,P,Q)

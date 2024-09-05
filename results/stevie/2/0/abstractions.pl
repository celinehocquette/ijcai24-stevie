ho_142(A,B,P) :- empty(A),empty(B)
ho_142(A,B,P) :- head(A,C),tail(A,D),head(B,E),tail(B,F),P(C,E),ho_142(D,F,P)

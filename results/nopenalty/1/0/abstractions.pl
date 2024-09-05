ho_36(A,P) :- empty(A)
ho_36(A,P) :- head(A,B),tail(A,C),P(B),ho_36(C,P)
ho_22(A,B,P,Q,R) :- P(A,B),Q(B,C),R(C)
ho_22(A,B,P,Q,R) :- P(A,C),ho_22(C,B,P,Q,R)

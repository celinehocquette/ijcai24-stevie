ho_141(A,B,P,Q,R) :- empty(A),empty(B)
ho_141(A,B,P,Q,R) :- P(A,C),Q(A,D),P(B,E),Q(B,F),R(C,E),ho_141(D,F,P,Q,R)

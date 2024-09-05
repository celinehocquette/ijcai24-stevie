ho_1(A,P) :- head(A,B),P(B)
ho_1(A,P) :- tail(A,B),ho_1(B,P)

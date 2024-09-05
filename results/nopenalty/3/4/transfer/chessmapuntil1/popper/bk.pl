

cons3(A,B,C) :- append([B],C,A).

rank8([_Piece,_Id,_File,8]).
neg_rank8(A):-
    \+rank8(A).
pawn([p,_Id,_File,_Rank]).
neg_pawn(A):- \+pawn(A).
rook([r,_Id,_File,_Rank]).
neg_rook(A):- \+rook(A).

head(L,H):-
    L=[H|_].
tail(L,T):-
    L=[_|T].
empty([]).
hold(A,B):-
  A=B.

forward(S1,S2):-
    ground(S1),
    S1=[Type,Id,X,Y1],
    S2=[Type,Id,X,Y2],
    Y1 < 8,
    Y2 is Y1+1.

back(S1,S2):-
    ground(S1),
    S1=[Type,Id,X,Y1],
    S2=[Type,Id,X,Y2],
    Y1 > 0,
    Y2 is Y1-1.

cons1(A,B,C):-
    cons(A,B,C).
cons2(A,B,C):-
    cons(A,B,C).
cons(A,B,C):-
    append([A],B,C).

non_functional(Atom1):-
    Atom1=..[f,A,B],
    Atom2=..[f,A,C],
    call(Atom2),
    B \= C.


ho_317(A,B,P,Q)  :- empty(A),call(P,B).

ho_317(A,B,P,Q)  :- head(A,C),tail(A,D),ho_317(D,E,P,Q),call(Q,E,C,B).

ho_36(A,B,C,P,Q)  :- zero_in(A),call(P,B,C).

ho_36(A,B,C,P,Q)  :- decrement(A,D),call(Q,B,E),ho_36(D,E,C,P,Q).

ho_25(A,P,Q)  :- empty(A).

ho_25(A,P,Q)  :- call(P,A,B),tail(A,C),call(Q,B),ho_25(C,P,Q).

ho_53(A,P,Q)  :- tail(A,B),empty(B).

ho_53(A,P,Q)  :- call(P,A,B),tail(A,C),ho_53(C,P,Q),call(P,C,D),call(Q,B,D).

ho_187(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_187(A,B,P,Q,R)  :- call(Q,A,C),tail(A,D),call(Q,B,E),tail(B,F),call(R,C,E),ho_187(D,F,P,Q,R).

ho_200(A,B,C,P,Q)  :- zero_in(A),eq_list(B,C).

ho_200(A,B,C,P,Q)  :- call(P,A,D),ho_200(D,B,E,P,Q),call(Q,E,C).

ho_501(A,B,P,Q,R)  :- empty(A),empty(B).

ho_501(A,B,P,Q,R)  :- call(P,A,C,D),call(Q,C),ho_501(D,B,P,Q,R).

ho_501(A,B,P,Q,R)  :- call(P,A,C,D),call(R,C),ho_501(D,E,P,Q,R),cons(C,E,B).

ho_134(A,B,P,Q,R)  :- empty(A),zero_int(B).

ho_134(A,B,P,Q,R)  :- head(A,C),call(P,A,D),call(Q,C),ho_134(D,B,P,Q,R).

ho_134(A,B,P,Q,R)  :- head(A,C),call(P,A,D),call(R,C),ho_134(D,E,P,Q,R),my_increment(E,B).

ho_8(A,B,P,Q,R)  :- call(P,A,B),call(Q,B,C),call(R,C).

ho_8(A,B,P,Q,R)  :- call(P,A,C),ho_8(C,B,P,Q,R).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_13(A,P,Q)  :- head(A,B),call(P,B).

ho_13(A,P,Q)  :- call(Q,A,B),ho_13(B,P,Q).


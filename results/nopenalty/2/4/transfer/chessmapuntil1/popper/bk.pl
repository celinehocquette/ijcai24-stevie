

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


ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_15(A,B,P,Q,R)  :- call(P,A,B),call(Q,B,C),call(R,C).

ho_15(A,B,P,Q,R)  :- call(P,A,C),ho_15(C,B,P,Q,R).

ho_356(A,B,P,Q)  :- empty(A),call(P,B).

ho_356(A,B,P,Q)  :- head(A,C),tail(A,D),ho_356(D,E,P,Q),call(Q,C,E,B).

ho_294(A,B,P,Q,R)  :- empty(A),empty(B).

ho_294(A,B,P,Q,R)  :- call(P,A,C,D),call(Q,C),ho_294(D,B,P,Q,R).

ho_294(A,B,P,Q,R)  :- call(P,A,C,D),ho_294(D,E,P,Q,R),call(R,C),cons(C,E,B).

ho_329(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_329(A,B,P,Q,R)  :- head(A,C),call(Q,A,D),head(B,E),call(Q,B,F),call(R,C,E),ho_329(D,F,P,Q,R).

ho_444(A,P,Q)  :- tail(A,B),empty(B).

ho_444(A,P,Q)  :- call(P,A,B),tail(A,C),ho_444(C,P,Q),call(P,C,D),call(Q,B,D).

ho_8(A,P,Q,R)  :- call(P,A,B),call(Q,B).

ho_8(A,P,Q,R)  :- call(R,A,B),ho_8(B,P,Q,R).

ho_45(A,P)  :- empty(A).

ho_45(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_45(C,P).

ho_42(A,B,C,P,Q,R)  :- call(P,A),call(Q,B,C).

ho_42(A,B,C,P,Q,R)  :- decrement(A,D),ho_42(D,B,E,P,Q,R),call(R,E,C).

ho_180(A,B,P,Q,R)  :- empty(A),zero_int(B).

ho_180(A,B,P,Q,R)  :- head(A,C),tail(A,D),call(P,C),ho_180(D,B,P,Q,R).

ho_180(A,B,P,Q,R)  :- head(A,C),tail(A,D),call(Q,C),ho_180(D,E,P,Q,R),call(R,E,B).


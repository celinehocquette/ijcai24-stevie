

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


ho_109(A,B,P,Q)  :- empty(A),call(P,B).

ho_109(A,B,P,Q)  :- head(A,C),tail(A,D),ho_109(D,E,P,Q),call(Q,C,E,B).

ho_500(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_500(A,B,C,P)  :- decrement(A,D),ho_500(D,B,E,P),call(P,E,C).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_251(A,B,P)  :- empty(A),empty(B).

ho_251(A,B,P)  :- head(A,C),tail(A,D),head(B,E),tail(B,F),call(P,C,E),ho_251(D,F,P).

ho_290(A,P)  :- head(A,B),call(P,B).

ho_290(A,P)  :- tail(A,B),ho_290(B,P).

ho_378(A,B,P,Q)  :- empty(A),call(P,B).

ho_378(A,B,P,Q)  :- head(A,C),tail(A,D),ho_378(D,E,P,Q),call(Q,E,C,B).

ho_734(A,P)  :- empty(A).

ho_734(A,P)  :- head(A,B),tail(A,C),my_succ(D,B),ho_734(C,P),one(E),call(P,D,E).

ho_270(A,B,P,Q)  :- empty(A),empty(B).

ho_270(A,B,P,Q)  :- cons3(A,C,D),call(P,C),ho_270(D,B,P,Q).

ho_270(A,B,P,Q)  :- cons3(A,C,D),call(Q,C),ho_270(D,E,P,Q),cons(C,E,B).

ho_6(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_6(A,B,P,Q)  :- call(P,A,C),ho_6(C,B,P,Q).

ho_319(A,P)  :- empty(A).

ho_319(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_319(C,P).

ho_137(A,B,P,Q)  :- empty(A),zero_int(B).

ho_137(A,B,P,Q)  :- head(A,C),tail(A,D),call(P,C),ho_137(D,B,P,Q).

ho_137(A,B,P,Q)  :- head(A,C),tail(A,D),call(Q,C),ho_137(D,E,P,Q),my_increment(E,B).

ho_9(A,P)  :- tail(A,B),empty(B).

ho_9(A,P)  :- head(A,B),tail(A,C),ho_9(C,P),head(C,D),call(P,B,D).


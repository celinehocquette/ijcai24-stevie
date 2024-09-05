

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


ho_251(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_251(A,B,P,Q)  :- call(P,A,C),ho_251(C,B,P,Q).

ho_44(A,P)  :- empty(A).

ho_44(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_44(C,P).

ho_132(A,B,P,Q)  :- empty(A),zero_int(B).

ho_132(A,B,P,Q)  :- head(A,C),tail(A,D),call(P,C),ho_132(D,B,P,Q).

ho_132(A,B,P,Q)  :- head(A,C),tail(A,D),call(Q,C),ho_132(D,E,P,Q),my_increment(E,B).

ho_308(A,P)  :- tail(A,B),empty(B).

ho_308(A,P)  :- head(A,B),tail(A,C),ho_308(C,P),head(C,D),call(P,B,D).

ho_16(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_16(A,B,C,P)  :- decrement(A,D),call(P,B,E),ho_16(D,E,C,P).

ho_101(A,B,P,Q)  :- empty(A),call(P,B).

ho_101(A,B,P,Q)  :- head(A,C),tail(A,D),ho_101(D,E,P,Q),call(Q,C,E,B).

ho_185(A,B,P)  :- empty(A),empty(B).

ho_185(A,B,P)  :- head(A,C),tail(A,D),head(B,E),tail(B,F),call(P,C,E),ho_185(D,F,P).

ho_489(A,B,P,Q)  :- empty(A),empty(B).

ho_489(A,B,P,Q)  :- cons3(A,C,D),call(P,C),ho_489(D,B,P,Q).

ho_489(A,B,P,Q)  :- cons3(A,C,D),call(Q,C),ho_489(D,E,P,Q),cons(C,E,B).

ho_6(A,P)  :- head(A,B),call(P,B).

ho_6(A,P)  :- tail(A,B),ho_6(B,P).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).




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


ho_61(A,B,P)  :- empty(A),empty(B).

ho_61(A,B,P)  :- head(A,C),tail(A,D),head(B,E),tail(B,F),call(P,C,E),ho_61(D,F,P).

ho_153(A,P)  :- empty(A).

ho_153(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_153(C,P).

ho_186(A,P)  :- tail(A,B),empty(B).

ho_186(A,P)  :- head(A,B),tail(A,C),ho_186(C,P),head(C,D),call(P,B,D).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_511(A,B,P,Q)  :- empty(A),call(P,B).

ho_511(A,B,P,Q)  :- head(A,C),tail(A,D),ho_511(D,E,P,Q),call(Q,C,E,B).

ho_234(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_234(A,B,C,P)  :- decrement(A,D),ho_234(D,B,E,P),call(P,E,C).

ho_14(A,P)  :- head(A,B),call(P,B).

ho_14(A,P)  :- tail(A,B),ho_14(B,P).

ho_102(A,B,P,Q)  :- empty(A),empty(B).

ho_102(A,B,P,Q)  :- cons3(A,C,D),call(P,C),ho_102(D,B,P,Q).

ho_102(A,B,P,Q)  :- cons3(A,C,D),call(Q,C),ho_102(D,E,P,Q),cons(C,E,B).

ho_5(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_5(A,B,P,Q)  :- call(P,A,C),ho_5(C,B,P,Q).

ho_24(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_24(A,B,C,P)  :- decrement(A,D),call(P,B,E),ho_24(D,E,C,P).

ho_44(A,B,P,Q)  :- empty(A),call(P,B).

ho_44(A,B,P,Q)  :- head(A,C),tail(A,D),ho_44(D,E,P,Q),call(Q,E,C,B).

ho_316(A,B,P,Q)  :- empty(A),zero_int(B).

ho_316(A,B,P,Q)  :- head(A,C),tail(A,D),call(P,C),ho_316(D,B,P,Q).

ho_316(A,B,P,Q)  :- head(A,C),tail(A,D),call(Q,C),ho_316(D,E,P,Q),my_increment(E,B).


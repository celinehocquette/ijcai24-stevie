

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


ho_68(A,B,P,Q)  :- empty(A),call(P,B).

ho_68(A,B,P,Q)  :- head(A,C),tail(A,D),ho_68(D,E,P,Q),call(Q,C,E,B).

ho_14(A,P,Q,R)  :- call(P,A).

ho_14(A,P,Q,R)  :- head(A,B),call(Q,A,C),call(R,B),ho_14(C,P,Q,R).

ho_199(A,B,P,Q)  :- empty(A),zero_int(B).

ho_199(A,B,P,Q)  :- head(A,C),tail(A,D),call(P,C),ho_199(D,B,P,Q).

ho_199(A,B,P,Q)  :- head(A,C),tail(A,D),call(Q,C),ho_199(D,E,P,Q),my_increment(E,B).

ho_155(A,B,P,Q,R)  :- empty(A),empty(B).

ho_155(A,B,P,Q,R)  :- call(P,A,C,D),call(Q,C),ho_155(D,B,P,Q,R).

ho_155(A,B,P,Q,R)  :- call(P,A,C,D),call(R,C),ho_155(D,E,P,Q,R),cons(C,E,B).

ho_438(A,P,Q,R)  :- call(P,A,B),empty(B).

ho_438(A,P,Q,R)  :- call(Q,A,B),call(P,A,C),ho_438(C,P,Q,R),call(Q,C,D),call(R,B,D).

ho_180(A,B,C,P,Q)  :- zero_in(A),eq_list(B,C).

ho_180(A,B,C,P,Q)  :- call(P,A,D),ho_180(D,B,E,P,Q),call(Q,E,C).

ho_121(A,B,P,Q,R)  :- call(P,A,B),call(Q,B,C),call(R,C).

ho_121(A,B,P,Q,R)  :- call(P,A,C),ho_121(C,B,P,Q,R).

ho_172(A,P,Q,R)  :- call(P,A,B),call(Q,B).

ho_172(A,P,Q,R)  :- call(R,A,B),ho_172(B,P,Q,R).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_54(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_54(A,B,P,Q,R)  :- call(Q,A,C),tail(A,D),call(Q,B,E),tail(B,F),call(R,C,E),ho_54(D,F,P,Q,R).




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


ho_22(A,B,P,Q,R)  :- call(P,A),call(Q,B).

ho_22(A,B,P,Q,R)  :- head(A,C),tail(A,D),ho_22(D,E,P,Q,R),call(R,C,E,B).

ho_445(A,P,Q,R)  :- call(P,A,B),empty(B).

ho_445(A,P,Q,R)  :- call(Q,A,B),call(P,A,C),ho_445(C,P,Q,R),call(Q,C,D),call(R,B,D).

ho_141(A,B,P,Q,R)  :- empty(A),empty(B).

ho_141(A,B,P,Q,R)  :- call(P,A,C),call(Q,A,D),call(P,B,E),call(Q,B,F),call(R,C,E),ho_141(D,F,P,Q,R).

ho_222(A,P)  :- empty(A).

ho_222(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_222(C,P).

ho_355(A,B,P,Q,R)  :- empty(A),empty(B).

ho_355(A,B,P,Q,R)  :- cons3(A,C,D),call(P,C),ho_355(D,B,P,Q,R).

ho_355(A,B,P,Q,R)  :- cons3(A,C,D),ho_355(D,E,P,Q,R),call(Q,C),call(R,C,E,B).

ho_241(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_241(A,B,C,P)  :- decrement(A,D),ho_241(D,B,E,P),call(P,E,C).

ho_172(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_172(A,B,C,P)  :- decrement(A,D),call(P,B,E),ho_172(D,E,C,P).

ho_238(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_238(A,B,P,Q)  :- call(P,A,C),ho_238(C,B,P,Q).

ho_160(A,P,Q)  :- head(A,B),call(P,B).

ho_160(A,P,Q)  :- call(Q,A,B),ho_160(B,P,Q).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_98(A,B,P,Q,R)  :- empty(A),zero_int(B).

ho_98(A,B,P,Q,R)  :- head(A,C),tail(A,D),call(P,C),ho_98(D,B,P,Q,R).

ho_98(A,B,P,Q,R)  :- head(A,C),tail(A,D),call(Q,C),ho_98(D,E,P,Q,R),call(R,E,B).


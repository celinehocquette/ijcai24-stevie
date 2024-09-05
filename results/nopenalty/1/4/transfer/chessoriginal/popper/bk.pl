

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


ho_610(A,B,P,Q,R)  :- call(P,A),call(Q,B).

ho_610(A,B,P,Q,R)  :- head(A,C),tail(A,D),ho_610(D,E,P,Q,R),call(R,C,E,B).

ho_76(A,B,C,P,Q)  :- zero_in(A),call(P,B,C).

ho_76(A,B,C,P,Q)  :- decrement(A,D),call(Q,B,E),ho_76(D,E,C,P,Q).

ho_287(A,B,P,Q,R)  :- empty(A),zero_int(B).

ho_287(A,B,P,Q,R)  :- call(P,A,C),tail(A,D),call(Q,C),ho_287(D,B,P,Q,R).

ho_287(A,B,P,Q,R)  :- call(P,A,C),tail(A,D),call(R,C),ho_287(D,E,P,Q,R),my_increment(E,B).

ho_138(A,P)  :- head(A,B),call(P,B).

ho_138(A,P)  :- tail(A,B),ho_138(B,P).

ho_19(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_19(A,B,P,Q)  :- call(P,A,C),ho_19(C,B,P,Q).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_213(A,B,P,Q,R)  :- empty(A),call(P,B).

ho_213(A,B,P,Q,R)  :- head(A,C),call(Q,A,D),ho_213(D,E,P,Q,R),call(R,E,C,B).

ho_496(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_496(A,B,P,Q,R)  :- cons3(A,C,D),call(Q,C),ho_496(D,B,P,Q,R).

ho_496(A,B,P,Q,R)  :- cons3(A,C,D),call(R,C),ho_496(D,E,P,Q,R),cons(C,E,B).

ho_135(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_135(A,B,P,Q,R)  :- call(Q,A,C),tail(A,D),call(Q,B,E),tail(B,F),call(R,C,E),ho_135(D,F,P,Q,R).

ho_405(A,P,Q,R)  :- call(P,A,B),call(Q,B).

ho_405(A,P,Q,R)  :- head(A,B),call(P,A,C),ho_405(C,P,Q,R),head(C,D),call(R,B,D).

ho_144(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_144(A,B,C,P)  :- decrement(A,D),ho_144(D,B,E,P),call(P,E,C).

ho_33(A,P)  :- empty(A).

ho_33(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_33(C,P).


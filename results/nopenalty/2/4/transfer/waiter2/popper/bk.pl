

%% COMPILED BK
at_end(p(Pos,Pos)).

wants_tea(s(RoboPos,_EndPos,Places)):-
    memberchk(p(RoboPos,tea,_,_),Places).

wants_coffee(s(RoboPos,_EndPos,Places)):-
    memberchk(p(RoboPos,coffee,_,_),Places).

head(s(Pos,Length,_),p(Pos,Length)).

move_right(S1,S2):-
    ground(S1),
    S1=s(RoboPos1,EndPos,Places),
    S2=s(RoboPos2,EndPos,Places),
    nonvar(EndPos),
    RoboPos1<EndPos+1,
    RoboPos2 is RoboPos1+1.

turn_cup_over(S1,S2):-
    ground(S1),
    S1=s(RoboPos,EndPos,Places1),
    S2=s(RoboPos,EndPos,Places2),
    update(Places1,
        p(RoboPos,Pref,down,empty),
        p(RoboPos,Pref,up,empty),
        Places2).

pour_tea(S1,S2):-
    ground(S1),
    S1=s(RoboPos,EndPos,Places1),
    S2=s(RoboPos,EndPos,Places2),
    update(Places1,p(RoboPos,Pref,up,empty),p(RoboPos,Pref,up,tea),Places2).

pour_coffee(S1,S2):-
    ground(S1),
    S1=s(RoboPos,EndPos,Places1),
    S2=s(RoboPos,EndPos,Places2),
    update(Places1,p(RoboPos,Pref,up,empty),p(RoboPos,Pref,up,coffee),Places2).

update(L1,A,B,L2):-
    A=p(Pos,Pref,Direction,Status),
    Dummy =.. [dummy|L1],
    arg(Pos,Dummy,p(Pos,Pref,Direction,Status)),
    setarg(Pos,Dummy,B),
    Dummy =..[dummy|L2].

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


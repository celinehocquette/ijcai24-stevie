

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


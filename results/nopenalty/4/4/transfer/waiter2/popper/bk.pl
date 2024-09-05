

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


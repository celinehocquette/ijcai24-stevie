

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





%f(A,B) :- ho_314(A,B,f1,f2).
%f1(A,B) :- pour_tea(A,C), move_right(C,B).
%f2(A) :- at_end(A).

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

ho_317(A,B,P,Q)  :- empty(A),call(P,B).

ho_317(A,B,P,Q)  :- head(A,C),tail(A,D),ho_317(D,E,P,Q),call(Q,E,C,B).

ho_36(A,B,C,P,Q)  :- zero_in(A),call(P,B,C).

ho_36(A,B,C,P,Q)  :- decrement(A,D),call(Q,B,E),ho_36(D,E,C,P,Q).

ho_25(A,P,Q)  :- empty(A).

ho_25(A,P,Q)  :- call(P,A,B),tail(A,C),call(Q,B),ho_25(C,P,Q).

ho_53(A,P,Q)  :- tail(A,B),empty(B).

ho_53(A,P,Q)  :- call(P,A,B),tail(A,C),ho_53(C,P,Q),call(P,C,D),call(Q,B,D).

ho_187(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_187(A,B,P,Q,R)  :- call(Q,A,C),tail(A,D),call(Q,B,E),tail(B,F),call(R,C,E),ho_187(D,F,P,Q,R).

ho_200(A,B,C,P,Q)  :- zero_in(A),eq_list(B,C).

ho_200(A,B,C,P,Q)  :- call(P,A,D),ho_200(D,B,E,P,Q),call(Q,E,C).

ho_501(A,B,P,Q,R)  :- empty(A),empty(B).

ho_501(A,B,P,Q,R)  :- call(P,A,C,D),call(Q,C),ho_501(D,B,P,Q,R).

ho_501(A,B,P,Q,R)  :- call(P,A,C,D),call(R,C),ho_501(D,E,P,Q,R),cons(C,E,B).

ho_134(A,B,P,Q,R)  :- empty(A),zero_int(B).

ho_134(A,B,P,Q,R)  :- head(A,C),call(P,A,D),call(Q,C),ho_134(D,B,P,Q,R).

ho_134(A,B,P,Q,R)  :- head(A,C),call(P,A,D),call(R,C),ho_134(D,E,P,Q,R),my_increment(E,B).

ho_8(A,B,P,Q,R)  :- call(P,A,B),call(Q,B,C),call(R,C).

ho_8(A,B,P,Q,R)  :- call(P,A,C),ho_8(C,B,P,Q,R).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_13(A,P,Q)  :- head(A,B),call(P,B).

ho_13(A,P,Q)  :- call(Q,A,B),ho_13(B,P,Q).

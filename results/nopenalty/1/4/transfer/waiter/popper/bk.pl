


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





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

ho_26(A,P)  :- empty(A).

ho_26(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_26(C,P).

ho_48(A,B,P,Q)  :- empty(A),call(P,B).

ho_48(A,B,P,Q)  :- head(A,C),tail(A,D),ho_48(D,E,P,Q),call(Q,C,E,B).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_65(A,P)  :- tail(A,B),empty(B).

ho_65(A,P)  :- head(A,B),tail(A,C),ho_65(C,P),head(C,D),call(P,B,D).

ho_5(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_5(A,B,C,P)  :- decrement(A,D),ho_5(D,B,E,P),call(P,E,C).

ho_286(A,B,P,Q)  :- empty(A),zero_int(B).

ho_286(A,B,P,Q)  :- head(A,C),tail(A,D),call(P,C),ho_286(D,B,P,Q).

ho_286(A,B,P,Q)  :- head(A,C),tail(A,D),call(Q,C),ho_286(D,E,P,Q),my_increment(E,B).

ho_143(A,B,P)  :- empty(A),empty(B).

ho_143(A,B,P)  :- head(A,C),tail(A,D),head(B,E),tail(B,F),call(P,C,E),ho_143(D,F,P).

ho_194(A,P)  :- head(A,B),call(P,B).

ho_194(A,P)  :- tail(A,B),ho_194(B,P).

ho_21(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_21(A,B,P,Q)  :- call(P,A,C),ho_21(C,B,P,Q).

ho_176(A,B,P,Q)  :- empty(A),empty(B).

ho_176(A,B,P,Q)  :- cons3(A,C,D),call(P,C),ho_176(D,B,P,Q).

ho_176(A,B,P,Q)  :- cons3(A,C,D),call(Q,C),ho_176(D,E,P,Q),cons(C,E,B).





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

ho_251(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_251(A,B,P,Q)  :- call(P,A,C),ho_251(C,B,P,Q).

ho_44(A,P)  :- empty(A).

ho_44(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_44(C,P).

ho_132(A,B,P,Q)  :- empty(A),zero_int(B).

ho_132(A,B,P,Q)  :- head(A,C),tail(A,D),call(P,C),ho_132(D,B,P,Q).

ho_132(A,B,P,Q)  :- head(A,C),tail(A,D),call(Q,C),ho_132(D,E,P,Q),my_increment(E,B).

ho_308(A,P)  :- tail(A,B),empty(B).

ho_308(A,P)  :- head(A,B),tail(A,C),ho_308(C,P),head(C,D),call(P,B,D).

ho_16(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_16(A,B,C,P)  :- decrement(A,D),call(P,B,E),ho_16(D,E,C,P).

ho_101(A,B,P,Q)  :- empty(A),call(P,B).

ho_101(A,B,P,Q)  :- head(A,C),tail(A,D),ho_101(D,E,P,Q),call(Q,C,E,B).

ho_185(A,B,P)  :- empty(A),empty(B).

ho_185(A,B,P)  :- head(A,C),tail(A,D),head(B,E),tail(B,F),call(P,C,E),ho_185(D,F,P).

ho_489(A,B,P,Q)  :- empty(A),empty(B).

ho_489(A,B,P,Q)  :- cons3(A,C,D),call(P,C),ho_489(D,B,P,Q).

ho_489(A,B,P,Q)  :- cons3(A,C,D),call(Q,C),ho_489(D,E,P,Q),cons(C,E,B).

ho_6(A,P)  :- head(A,B),call(P,B).

ho_6(A,P)  :- tail(A,B),ho_6(B,P).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).


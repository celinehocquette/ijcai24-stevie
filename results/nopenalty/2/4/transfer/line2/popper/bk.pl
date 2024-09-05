
non_functional(Atom1):-
    Atom1=..[P,A,B],
    Atom2=..[P,A,C],
    call(Atom2),
    (myvar(C); B \= C).


width(w(_,_,Width,_,_), Width).
height(w(_,_,_,Height,_), Height).

myvar(A) :- var(A).
myvar(w(X,Y,_Width,_Height,_Grid)) :- var(X) ; var(Y).

until(A,B,P,Q) :- call(Q,A), eq(A,B).
until(A,B,P,Q) :- call(P,A,C), until(C,B,P,Q) .

eq(A,A).

eq_list(A,A).

func_test(_,Atom2,_):-
  Atom2 = [_P,_A,Z],
  var(Z).
func_test(_,Atom2,_):-
  Atom2 = [_P,_A,Z],
  arg(_, Z, V),
  var(V).
func_test(Atom1,Atom2,Condition):-
  Atom1 = [P,A,B],
  Atom2 = [P,A,Z],
  nonvar(Z),
  \+ ((arg(_, Z, V), var(V))),
  Condition = (Z = B).

head(w(X,Y,Width,Height,_Grid), p(X,Y,Width,Height)).

at_top(p(_X,0,_Width,_Height)).

at_bottom(p(_X,Height1,_Width,Height)) :- nonvar(Height), Height1 is Height-1.

at_left(p(0,_Y,_Width,_Height)).

at_right(p(Width1,_Y,Width,_Height)) :- nonvar(Width), Width1 is Width-1.

at_row1(w(1,_Height1,_Width,_Height,_Grid)).
at_row2(w(2,_Height1,_Width,_Height,_Grid)).
at_row3(w(3,_Height1,_Width,_Height,_Grid)).
at_row4(w(4,_Height1,_Width,_Height,_Grid)).

at_col1(w(_Width1,1,_Width,_Height,_Grid)).
at_col2(w(_Width1,2,_Width,_Height,_Grid)).
at_col3(w(_Width1,3,_Width,_Height,_Grid)).
at_col4(w(_Width1,4,_Width,_Height,_Grid)).


neg_at_top(S) :- \+ at_top(S).

neg_at_bottom(S) :- \+ at_bottom(S).

neg_at_left(S) :- \+ at_left(S).

neg_at_right(S) :- \+ at_right(S).

pos(X,Y,Width,Pos):-
    nonvar(X),
    nonvar(Y),
    Pos is X + (Width * Y), Pos>=0.

draw1(w(X,Y,Width,Height,Grid1),w(X,Y,Width,Height,Grid2)):-
    pos(X,Y,Width,Pos),
    replace_at(Pos,1,Grid1,Grid2).

draw0(w(X,Y,Width,Height,Grid1),w(X,Y,Width,Height,Grid2)):-
    pos(X,Y,Width,Pos),
    replace_at(Pos,0,Grid1,Grid2).

move_right(w(X1,Y,Width,Height,Grid),w(X2,Y,Width,Height,Grid)):-
    nonvar(X1),
    X1 < Width-1,
    X2 is X1+1.

move_left(w(X1,Y,Width,Height,Grid),w(X2,Y,Width,Height,Grid)):-
    nonvar(X1),
    X1 > 1,
    X2 is X1-1.

move_down(w(X,Y1,Width,Height,Grid),w(X,Y2,Width,Height,Grid)):-
    nonvar(Y1),
    Y1 < Height-1,
    Y2 is Y1+1.

move_up(w(X,Y1,Width,Height,Grid),w(X,Y2,Width,Height,Grid)):-
    nonvar(Y1),
    Y1 > 1,
    Y2 is Y1-1.

replace_at(Pos, New, L1, L2):-
    findall(X, (nth0(Index,L1,Old), (Index == Pos -> X=New ; X=Old)), L2).

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


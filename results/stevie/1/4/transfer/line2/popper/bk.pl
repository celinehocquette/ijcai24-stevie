
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

ho_61(A,B,P)  :- empty(A),empty(B).

ho_61(A,B,P)  :- head(A,C),tail(A,D),head(B,E),tail(B,F),call(P,C,E),ho_61(D,F,P).

ho_153(A,P)  :- empty(A).

ho_153(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_153(C,P).

ho_186(A,P)  :- tail(A,B),empty(B).

ho_186(A,P)  :- head(A,B),tail(A,C),ho_186(C,P),head(C,D),call(P,B,D).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_511(A,B,P,Q)  :- empty(A),call(P,B).

ho_511(A,B,P,Q)  :- head(A,C),tail(A,D),ho_511(D,E,P,Q),call(Q,C,E,B).

ho_234(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_234(A,B,C,P)  :- decrement(A,D),ho_234(D,B,E,P),call(P,E,C).

ho_14(A,P)  :- head(A,B),call(P,B).

ho_14(A,P)  :- tail(A,B),ho_14(B,P).

ho_102(A,B,P,Q)  :- empty(A),empty(B).

ho_102(A,B,P,Q)  :- cons3(A,C,D),call(P,C),ho_102(D,B,P,Q).

ho_102(A,B,P,Q)  :- cons3(A,C,D),call(Q,C),ho_102(D,E,P,Q),cons(C,E,B).

ho_5(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_5(A,B,P,Q)  :- call(P,A,C),ho_5(C,B,P,Q).

ho_24(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_24(A,B,C,P)  :- decrement(A,D),call(P,B,E),ho_24(D,E,C,P).

ho_44(A,B,P,Q)  :- empty(A),call(P,B).

ho_44(A,B,P,Q)  :- head(A,C),tail(A,D),ho_44(D,E,P,Q),call(Q,E,C,B).

ho_316(A,B,P,Q)  :- empty(A),zero_int(B).

ho_316(A,B,P,Q)  :- head(A,C),tail(A,D),call(P,C),ho_316(D,B,P,Q).

ho_316(A,B,P,Q)  :- head(A,C),tail(A,D),call(Q,C),ho_316(D,E,P,Q),my_increment(E,B).


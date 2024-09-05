
int(_).

is_list([]).
is_list([_|_]).

fold(_P,Acc,[],Acc).
fold(P,Acc,[H|T],Out) :- call(P,Acc,H,Inter),fold(P,Inter,T,Out).

rotate1([H|T],U) :- append(T,[H],U), last(T,V), \+V=1.

increment(A,B):-
    (nonvar(A) -> (\+ is_list(A), integer(A), A>=0); true),
    (nonvar(B) -> (\+ is_list(B), integer(B), B>=1); true),
    my_succ(A,B).

decrement(A,B):-
    (nonvar(A) -> (\+ is_list(A), integer(A), A>=1); true),
    (nonvar(B) -> (\+ is_list(B), integer(B), B>=0); true),
    my_succ(B,A).

decrement_int(A,B):-
    (nonvar(A) -> (\+ is_list(A), integer(A), A>=1); true),
    (nonvar(B) -> (\+ is_list(B), integer(B), B>=0); true),
    my_succ(B,A).


incrementin(A,B):-
    (nonvar(A) -> (\+ is_list(A), integer(A), A>=0); true),
    (nonvar(B) -> (\+ is_list(B), integer(B), B>=1); true),
    my_succ(A,B).

decrementin(A,B):-
    (nonvar(A) -> (\+ is_list(A), integer(A), A>=1); true),
    (nonvar(B) -> (\+ is_list(B), integer(B), B>=0); true),
    my_succ(B,A).


my_increment(A,B):-
    (nonvar(A) -> (\+ is_list(A), integer(A), A>=0); true),
    (nonvar(B) -> (\+ is_list(B), integer(B), B>=1); true),
    my_succ(A,B).

my_decrement(A,B):-
    (nonvar(A) -> (\+ is_list(A), integer(A), A>=1); true),
    (nonvar(B) -> (\+ is_list(B), integer(B), B>=0); true),
    my_succ(B,A).

changesign(A,B) :- nonvar(A), integer(A), B is -A.

my_succ(A,B) :- nonvar(A), integer(A), A<0,!, A1 is -A, succ(B1,A1), B is -B1.
my_succ(A,B) :- nonvar(B), integer(B), B<1,!, B1 is -B, succ(B1,A1), A is -A1.
my_succ(A,B) :- nonvar(A), integer(A), A>=0,!, succ(A,B).
my_succ(A,B) :- nonvar(B), integer(B), B>=1,!, succ(A,B).

square(X,Y) :- nonvar(X), integer(X), Y is X*X.
cube(X,Y) :- nonvar(X), integer(X), Y is X*X*X.
double(X,Y) :- nonvar(X), integer(X), Y is 2*X.
triple(X,Y) :- nonvar(X), integer(X), Y is 3*X.
my_double(X,Y) :- nonvar(X), integer(X), Y is 2*X.
my_triple(X,Y) :- nonvar(X), integer(X), Y is 3*X.

my_length(A,B):-
    (nonvar(A) -> is_list(A); true),
    (nonvar(B) -> (\+ is_list(B), integer(B)); true),
    length(A,B).

ord(A,B) :-
    nonvar(A),
    atom(A),
    (var(B);integer(B)),
    atom_codes(A,[C]),
    C=B.

inttochar(A,B) :-
    nonvar(A),
    integer(A),
    A>=97,
    A=<122,
    atom_codes(C,[A]),
    C=B.

bin(0,[0]) :- !.
bin(1,[1]) :- !.
bin(A,B) :-
   \+ is_list(A),
    integer(A),
   A>1,
   X is A mod 2,
   Y is A//2,
   bin(Y,B1),
   append(B1,[X],B).

mod2(A,B) :- nonvar(A), \+is_list(A), integer(A), B is A mod 2.

max(A,B,A) :- nonvar(A), nonvar(B), A>= B,!.
max(A,B,B) :- nonvar(A), nonvar(B), A< B,!.

min(A,B,A) :- nonvar(A), nonvar(B), A=< B,!.
min(A,B,B) :- nonvar(A), nonvar(B), A> B,!.

prepend(A,B,C):-
    append([A],B,C).

cons2(A,B,C):-
    append(A,[B],C).
cons3(A,B,C):-
    append([B],C,A).
consend(A,B,C) :-
    append(B,[A],C).
comps([H|T],H,T).
cons(A,B,C) :-
    append([A],B,C).

addhead1([H1|T],[H2|T]) :- nonvar(H1), \+ is_list(H1), H1<1000, H2 is H1+1.
decrementhead1([H1|T],[H2|T]) :- nonvar(H1),\+ is_list(H1), -1000<H1, H2 is H1-1.
addlast1(A,B) :- nonvar(A), reverse(A,C), addhead1(C,D), reverse(D,B).
minuslast1(A,B) :- nonvar(A), reverse(A,C), decrementhead1(C,D), reverse(D,B).
minushead1(A,B) :- nonvar(A), decrementhead1(A,B).
doublehead([H1|T],[H2|T]) :- nonvar(H1), \+ is_list(H1), H1<100000, H2 is 2*H1.
squarehead([H1|T],[H2|T]) :- nonvar(H1), \+ is_list(H1), H1<100000, H2 is H1*H1.

duplhead([H|T],[H,H|T]) :- nonvar(H).

xor(1,1,0).
xor(1,0,1).
xor(0,1,1).
xor(0,0,0).

or_element(0,0,0).
or_element(0,1,1).
or_element(1,0,1).
or_element(1,1,1).

and_element(0,0,0).
and_element(0,1,0).
and_element(1,0,0).
and_element(1,1,1).

tail([_|T],T).
head([H|_],H).
head_list([H|_],H) :- is_list(H).
tail_list([_|T],T).
sum(A,B,C):-
    nonvar(A), nonvar(B),
    integer(A), integer(B),
    C is A+B.
mult(A,B,C):-
    nonvar(A), nonvar(B),
    integer(A), integer(B),
    C is A*B.
empty([]).

element([X|_],X):-!.
element([_|T],X):-
    element(T,X).

empty_in([]).
empty_out([]).

zero_in(0).
one_in(1).
zero_int(0).
one_int(1).
zero(0).
one(1).
two(2).
three(3).
minusone(-1).

negative(A) :- integer(A), A<0.
positive(A) :- integer(A), A>=0.

gt(A,B):-
    nonvar(A),
    nonvar(B),
    \+is_list(A),
    \+is_list(B),
    integer(A),
    integer(B),
    A > B.

eq(A,A).
eq_list(A,A).

geq(A,B):-
    nonvar(A),
    nonvar(B),
    \+is_list(A),
    \+is_list(B),
    integer(A),
    integer(B),
    A >= B.


leq(A,B):-
    nonvar(A),
    nonvar(B),
    \+is_list(A),
    \+is_list(B),
    integer(A),
    integer(B),
    A =< B.


even(A):-
    nonvar(A),
    integer(A),
    \+ is_list(A),
    0 is A mod 2.

odd(A):-
    nonvar(A),
    integer(A),
    \+ is_list(A),
    1 is A mod 2.


c0(0).
c1(1).
c2(2).
c3(3).
c4(4).
c5(5).
c6(6).
c7(7).
c8(8).
c9(9).
c10(10).
c11(11).
c12(12).
c13(13).
c14(14).
c15(15).
c16(16).
c17(17).
c18(18).
c19(19).
c20(20).
c21(21).
c22(22).
c23(23).
c24(24).
c25(25).
c26(26).
c27(27).
c28(28).
c29(29).
c30(30).
c31(31).
c32(32).
c33(33).
c34(34).
c35(35).
c36(36).
c37(37).
c38(38).
c39(39).
c40(40).
c41(41).
c42(42).
c43(43).
c44(44).
c45(45).
c46(46).
c47(47).
c48(48).
c49(49).
c50(50).
c51(51).
c52(52).
c53(53).
c54(54).
c55(55).
c56(56).
c57(57).
c58(58).
c59(59).
c60(60).
c61(61).
c62(62).
c63(63).
c64(64).
c65(65).
c66(66).
c67(67).
c68(68).
c69(69).
c70(70).
c71(71).
c72(72).
c73(73).
c74(74).
c75(75).
c76(76).
c77(77).
c78(78).
c79(79).
c80(80).
c81(81).
c82(82).
c83(83).
c84(84).
c85(85).
c86(86).
c87(87).
c88(88).
c89(89).
c90(90).
c91(91).
c92(92).
c93(93).
c94(94).
c95(95).
c96(96).
c97(97).
c98(98).
c99(99).
c100(100).

c65536(65536).
c128(128).
c256(256).


geq50(A) :- nonvar(A), integer(A), A >= 50.
geq100(A) :- nonvar(A), integer(A), A >= 100.


ho_432(A,P,Q)  :- call(P,A,B),empty(B).

ho_432(A,P,Q)  :- head(A,B),call(P,A,C),ho_432(C,P,Q),head(C,D),call(Q,B,D).

ho_151(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_151(A,B,P,Q,R)  :- cons3(A,C,D),call(Q,C),ho_151(D,B,P,Q,R).

ho_151(A,B,P,Q,R)  :- cons3(A,C,D),call(R,C),ho_151(D,E,P,Q,R),cons(C,E,B).

ho_53(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_53(A,B,P,Q,R)  :- call(Q,A,C),tail(A,D),call(Q,B,E),tail(B,F),call(R,C,E),ho_53(D,F,P,Q,R).

ho_183(A,B,C,P,Q)  :- call(P,A),eq_list(B,C).

ho_183(A,B,C,P,Q)  :- decrement(A,D),ho_183(D,B,E,P,Q),call(Q,E,C).

ho_55(A,B,P)  :- empty(A),zero(B).

ho_55(A,B,P)  :- head(A,C),tail(A,D),ho_55(D,E,P),call(P,C,E,B).

ho_248(A,B,P,Q,R)  :- empty(A),call(P,B).

ho_248(A,B,P,Q,R)  :- head(A,C),tail(A,D),call(Q,C),ho_248(D,B,P,Q,R).

ho_248(A,B,P,Q,R)  :- head(A,C),tail(A,D),call(R,C),ho_248(D,E,P,Q,R),my_increment(E,B).

ho_118(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_118(A,B,P,Q)  :- call(P,A,C),ho_118(C,B,P,Q).

ho_14(A,P,Q,R)  :- call(P,A).

ho_14(A,P,Q,R)  :- call(Q,A,B),tail(A,C),call(R,B),ho_14(C,P,Q,R).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_166(A,P)  :- head(A,B),call(P,B).

ho_166(A,P)  :- tail(A,B),ho_166(B,P).


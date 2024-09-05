
any(_).
int(A) :- integer(A).

head([H|_],H).
tail([_|T],T).
empty([]).
leaf(t(_,[])).
root(t(R,_),R).
children(t(_,C),C).

eq_list(A,A).


max(A,B,A) :- integer(A), integer(B), A>= B,!.
max(A,B,B) :- integer(A), integer(B), A<B.

zero(0).
zero_in(0).
one(1).
less0(K):- integer(K),0<K.

eq(A,A).

empty([]).

pred(A,B) :- integer(A), succ(B,A).

is_list([]).
is_list([_|_]).

reverse([],[]).
reverse([H|T],R) :- reverse(T,U), append(U,[H],R).

last([H],H).
last([_|T],L) :- last(T,L).

front([_],[]).
front([H|T],[H|Y]):-front(T,Y).

increment(A,B):-
    (nonvar(A) -> (\+ is_list(A), integer(A), A>=0); true),
    (nonvar(B) -> (\+ is_list(B), integer(B), B>=1); true),
    my_succ(A,B).

my_succ(A,B) :- nonvar(A), integer(A), A<0,!, A1 is -A, succ(B1,A1), B is -B1.
my_succ(A,B) :- nonvar(B), integer(B), B<1,!, B1 is -B, succ(B1,A1), A is -A1.
my_succ(A,B) :- nonvar(A), integer(A), A>=0,!, succ(A,B).
my_succ(A,B) :- nonvar(B), integer(B), B>=1,!, succ(A,B).

my_increment(A,B):-
    (nonvar(A) -> integer(A), \+ is_list(A); true),
    (nonvar(B) -> integer(B), \+ is_list(B); true),
   (nonvar(A);nonvar(B)),
    succ(A,B).

decrement(A,B):-
    (nonvar(A) -> integer(A), \+ is_list(A); true),
    (nonvar(B) -> integer(B), \+ is_list(B); true),
   (nonvar(A);nonvar(B)),
    succ(B,A).


decrement_int(A,B) :-
(nonvar(A) -> integer(A), \+ is_list(A); true),
    (nonvar(B) -> integer(B), \+ is_list(B); true),
   (nonvar(A);nonvar(B)),
    succ(B,A).

my_length(A,B):-
    (nonvar(A) -> is_list(A); true),
    (nonvar(B) -> \+is_list(B); true),
    length(A,B).


negative(A) :- integer(A), A<0.
positive(A) :- integer(A), A>=0.


cons(A,B,C):-
    append([A],B,C).

cons1(A,B,C):-
    append(A,[B],C).
cons2(A,B,C):-
    append([B],C,A).
cons3(A,B,C):-
    append([B],C,A).

comps([H|T],H,T).


sum(A,B,C):-
    (nonvar(A) -> \+ is_list(A); true),
    (nonvar(B) -> \+ is_list(B); true),
    (nonvar(C) -> \+ is_list(B); true),
    C is A+B.

mult(A,B,C):-
    (nonvar(A) -> \+ is_list(A); true),
    (nonvar(B) -> \+ is_list(B); true),
    (nonvar(C) -> \+ is_list(B); true),
    C is A*B.


char_to_int(A,B) :-  code_type(A,alnum), \+integer(A), (var(B);integer(B)), char_code(A,B).
int_to_char(A,B) :-
    nonvar(A),
    integer(A),
    A>=97,
    A=<122,
    atom_codes(C,[A]),
    C=B.

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



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


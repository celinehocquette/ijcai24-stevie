
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


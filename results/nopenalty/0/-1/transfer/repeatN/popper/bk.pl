
:-style_check(-singleton).

any(_).
int(A) :- integer(A).

true(true).

member_operation(A,B,P) :- head(A,C),call(P,C,B).
member_operation(A,B,P) :- tail(A,C),member_operation(C,B,P).

fold(A,B,P,Q) :- empty(A),call(P,B).
fold(A,B,P,Q) :- head(A,C),tail(A,D),fold(D,E,P,Q),call(Q,C,E,B).

all(A,P) :- empty(A).
all(A,P) :- head(A,B),tail(A,C),call(P,B),all(C,P).

any(A,P) :- head(A,B),call(P,B).
any(A,P) :- tail(A,C),any(C,P).

iterate(A,B,C,P) :- zero(A),eq_list(B,C).
iterate(A,B,C,P) :- decrement(A,D),iterate(D,B,E,P),call(P,E,C).

iterate_element(A,B,C,P) :- zero(A),eq_list(B,C).
iterate_element(A,B,C,P) :- decrement(A,D),iterate_element(D,B,E,P),call(P,E,C).

sorted_ho(A,P) :- tail(A,B),empty(B).
sorted_ho(A,P) :- head(A,B),tail(A,C),head(C,D),call(P,B,D),sorted_ho(C,P).

caselist(P,Q,A,Y):- call(P,Y), empty(A).
caselist(P,Q,A,Y):- head(A,B), tail(A,C), call(Q,B,C,Y).

map_list(A,B,P):- empty(A), empty(B).
map_list(A,B,P):- head(A,C), tail(A,D), call(P,C,E), map_list(D,F,P), head(B,E), tail(B,F).

map(A,B,P):- empty(A), empty(B).
map(A,B,P):- head(A,C), tail(A,D), call(P,C,E), map(D,F,P), head(B,E), tail(B,F).

eq_list(A,A).

leaf(t(_,[])).
children(t(_,C),C).
root(t(R,_),R).

tail([_|T],T).
head([H|_],H).

head2([H|_],R) :- root(H,R).

max(A,B,A) :- integer(A), integer(B), A>= B,!.
max(A,B,B) :- integer(A), integer(B), A<B.

zero(0).
zero_in(0).
zero_int(0).
one(1).
less0(K):- integer(K),0<K.

len(A,B) :- length(A,B).

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


char_to_int(A,B) :- \+ is_list(A),\+integer(A),code_type(A,alnum), (var(B);integer(B)), char_code(A,B).
int_to_char(A,B) :-
    \+ is_list(A),
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




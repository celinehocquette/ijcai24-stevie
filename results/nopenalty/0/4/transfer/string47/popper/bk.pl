
eq_list(A,A).

cons(A,B,C):-
    append([A],B,C).
singleton(A,[A]).

empty([]).
neg_empty(A) :- nonvar(A), \+ empty(A).

head(L,H):-
  L=[H|_].

tail(L,T):-
  L=[_|T].

neg_uppercase(A):-
  nonvar(A), \+is_uppercase(A).
is_uppercase(A) :- nonvar(A), uppercase(A).
neg_lowercase(A):-
  nonvar(A), \+lowercase(A).
is_lowercase(A) :- nonvar(A), lowercase(A).
neg_letter(A):-
  nonvar(A), \+letter(A).
is_letter(A) :- nonvar(A), letter(A).
neg_number(A):-
  nonvar(A), \+is_number(A).
neg_space(A):-
  nonvar(A), \+is_space(A).
is_space(s(_)).

my_reverse(A,B):-
  ground(A),
  (ground(B) -> A\=B; true),
  reverse(A,B),
  A\=B.


uppercase(u(_)).
lowercase(l(_)).

letter(u(_)).
letter(l(_)).

is_number(n(_)).

mk_uppercase(H, H):- uppercase(H),!.
mk_uppercase(H1, H2):-
    convert_case(H2, H1).
mk_lowercase(H, H):- lowercase(H),!.
mk_lowercase(H1, H2):-
    convert_case(H1, H2).

convert_case(u(A),l(A)).


func_test(Atom1,Atom2,Condition):-
  Atom1 = [P,A,B],
  Atom2 = [P,A,Z],
  Condition = (Z = B).


non_functional(Atom1):-
    Atom1=..[P,A,_],
    Atom2=..[P,A,_],
    timeout(T),
    catch(call_with_time_limit(T, \+call(Atom2)),time_limit_exceeded,true),!.
non_functional(Atom1):-
    Atom1=..[P,A,B],
    Atom2=..[P,A,C],
    timeout(T),
    catch(call_with_time_limit(T, call(Atom2)),time_limit_exceeded,false),!,
    (myvar(C); B \= C).


cons3(A,B,C) :- append([B],C,A).


myvar(C) :- var(C).
myvar([H|_]) :- var(H).
myvar([H|T]) :- nonvar(H), var(T).
myvar([H|T]) :- nonvar(H), myvar(T).

front(A,B) :- reverse(A,C), tail(C,D), reverse(D,B).

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


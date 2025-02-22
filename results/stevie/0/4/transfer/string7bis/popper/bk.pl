
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


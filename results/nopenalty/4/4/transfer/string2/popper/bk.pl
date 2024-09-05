
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

ho_68(A,B,P,Q)  :- empty(A),call(P,B).

ho_68(A,B,P,Q)  :- head(A,C),tail(A,D),ho_68(D,E,P,Q),call(Q,C,E,B).

ho_14(A,P,Q,R)  :- call(P,A).

ho_14(A,P,Q,R)  :- head(A,B),call(Q,A,C),call(R,B),ho_14(C,P,Q,R).

ho_199(A,B,P,Q)  :- empty(A),zero_int(B).

ho_199(A,B,P,Q)  :- head(A,C),tail(A,D),call(P,C),ho_199(D,B,P,Q).

ho_199(A,B,P,Q)  :- head(A,C),tail(A,D),call(Q,C),ho_199(D,E,P,Q),my_increment(E,B).

ho_155(A,B,P,Q,R)  :- empty(A),empty(B).

ho_155(A,B,P,Q,R)  :- call(P,A,C,D),call(Q,C),ho_155(D,B,P,Q,R).

ho_155(A,B,P,Q,R)  :- call(P,A,C,D),call(R,C),ho_155(D,E,P,Q,R),cons(C,E,B).

ho_438(A,P,Q,R)  :- call(P,A,B),empty(B).

ho_438(A,P,Q,R)  :- call(Q,A,B),call(P,A,C),ho_438(C,P,Q,R),call(Q,C,D),call(R,B,D).

ho_180(A,B,C,P,Q)  :- zero_in(A),eq_list(B,C).

ho_180(A,B,C,P,Q)  :- call(P,A,D),ho_180(D,B,E,P,Q),call(Q,E,C).

ho_121(A,B,P,Q,R)  :- call(P,A,B),call(Q,B,C),call(R,C).

ho_121(A,B,P,Q,R)  :- call(P,A,C),ho_121(C,B,P,Q,R).

ho_172(A,P,Q,R)  :- call(P,A,B),call(Q,B).

ho_172(A,P,Q,R)  :- call(R,A,B),ho_172(B,P,Q,R).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_54(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_54(A,B,P,Q,R)  :- call(Q,A,C),tail(A,D),call(Q,B,E),tail(B,F),call(R,C,E),ho_54(D,F,P,Q,R).


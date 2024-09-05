
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

ho_610(A,B,P,Q,R)  :- call(P,A),call(Q,B).

ho_610(A,B,P,Q,R)  :- head(A,C),tail(A,D),ho_610(D,E,P,Q,R),call(R,C,E,B).

ho_76(A,B,C,P,Q)  :- zero_in(A),call(P,B,C).

ho_76(A,B,C,P,Q)  :- decrement(A,D),call(Q,B,E),ho_76(D,E,C,P,Q).

ho_287(A,B,P,Q,R)  :- empty(A),zero_int(B).

ho_287(A,B,P,Q,R)  :- call(P,A,C),tail(A,D),call(Q,C),ho_287(D,B,P,Q,R).

ho_287(A,B,P,Q,R)  :- call(P,A,C),tail(A,D),call(R,C),ho_287(D,E,P,Q,R),my_increment(E,B).

ho_138(A,P)  :- head(A,B),call(P,B).

ho_138(A,P)  :- tail(A,B),ho_138(B,P).

ho_19(A,B,P,Q)  :- call(P,A,B),head(B,C),call(Q,C).

ho_19(A,B,P,Q)  :- call(P,A,C),ho_19(C,B,P,Q).

ho_1(A,B,P)  :- call(P,A,C),call(P,C,D),call(P,D,E),call(P,E,F),call(P,F,B).

ho_213(A,B,P,Q,R)  :- empty(A),call(P,B).

ho_213(A,B,P,Q,R)  :- head(A,C),call(Q,A,D),ho_213(D,E,P,Q,R),call(R,E,C,B).

ho_496(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_496(A,B,P,Q,R)  :- cons3(A,C,D),call(Q,C),ho_496(D,B,P,Q,R).

ho_496(A,B,P,Q,R)  :- cons3(A,C,D),call(R,C),ho_496(D,E,P,Q,R),cons(C,E,B).

ho_135(A,B,P,Q,R)  :- call(P,A),call(P,B).

ho_135(A,B,P,Q,R)  :- call(Q,A,C),tail(A,D),call(Q,B,E),tail(B,F),call(R,C,E),ho_135(D,F,P,Q,R).

ho_405(A,P,Q,R)  :- call(P,A,B),call(Q,B).

ho_405(A,P,Q,R)  :- head(A,B),call(P,A,C),ho_405(C,P,Q,R),head(C,D),call(R,B,D).

ho_144(A,B,C,P)  :- zero_in(A),eq_list(B,C).

ho_144(A,B,C,P)  :- decrement(A,D),ho_144(D,B,E,P),call(P,E,C).

ho_33(A,P)  :- empty(A).

ho_33(A,P)  :- head(A,B),tail(A,C),call(P,B),ho_33(C,P).


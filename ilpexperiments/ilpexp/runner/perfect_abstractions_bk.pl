
include([], _, []).
include([H|T], Included, P) :-
(call(P, H) -> Included=[H|Included1];
Included = Included1),
include(T, Included1, P).

exclude([], _, []).
exclude([H|T], Included, P) :-
(call(P, H) -> Included = Included1;
Included=[H|Included1]), exclude(T, Included1, P).

maplist([], [], _).
maplist([H1|T1], [H2|T2], Goal) :-
call(Goal, H1, H2),
maplist(T1, T2, Goal).


convlist([], [], _).
convlist([H0|T0], ListOut, Goal) :-
call(Goal, H0, H)-> ListOut = [H|T],
convlist(T0, T, Goal);
convlist(T0, ListOut, Goal).

foldl([], V, V, _). 
foldl([H|T], V0, V, Goal) :- 
call(Goal, H, V0, V1), 
foldl(T, V1, V, Goal).

partition([], [], [], _).
partition([H|T], Incl, Excl, Pred) :-
(call(Pred, H) -> Incl = [H|I],
partition(T, I, Excl, Pred);
Excl = [H|E], partition(T, Incl, E, Pred)).

scanl([], _, [], _). 
scanl([H|T], V, [VH|VT], Goal) :- 
call(Goal, H, V, VH),
scanl(T, VH, VT, Goal).
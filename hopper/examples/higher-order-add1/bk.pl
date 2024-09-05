tail([_|T],T).
head([H|_],H).
empty([]).
my_append(A,B,C):-
    append(A,[B],C).

add1(A,B) :- B is A+1.

fold(_P,Acc,[],Acc).
fold(P,Acc,[H|T],Out) :- call(P,Acc,H,Inter),fold(P,Inter,T,Out).

map(_P,[],[]).
map(P,[H|T],[H1|T1]) :- call(P,H,H1),map(P,T,T1).

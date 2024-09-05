
map(_, [], []).
map(P, [H|T], [H2|T2]) :- call(P, H, H2), map(P, T, T2).


char_to_int('a',0).
char_to_int('b',1).
char_to_int('c',2).
char_to_int('d',3).
char_to_int('e',4).
char_to_int('f',5).
char_to_int('g',6).
char_to_int('h',7).
char_to_int('i',8).
char_to_int('j',9).
char_to_int('k',10).
char_to_int('l',11).
char_to_int('m',12).
char_to_int('n',13).
char_to_int('o',14).
char_to_int('p',15).
char_to_int('q',16).
char_to_int('r',17).
char_to_int('s',18).
char_to_int('t',19).
char_to_int('u',20).
char_to_int('v',21).
char_to_int('w',22).
char_to_int('x',23).
char_to_int('y',24).
char_to_int('z',25).

int_to_char(0,'a').
int_to_char(1,'b').
int_to_char(2,'c').
int_to_char(3,'d').
int_to_char(4,'e').
int_to_char(5,'f').
int_to_char(6,'g').
int_to_char(7,'h').
int_to_char(8,'i').
int_to_char(9,'j').
int_to_char(10,'k').
int_to_char(11,'l').
int_to_char(12,'m').
int_to_char(13,'n').
int_to_char(14,'o').
int_to_char(15,'p').
int_to_char(16,'q').
int_to_char(17,'r').
int_to_char(18,'s').
int_to_char(19,'t').
int_to_char(20,'u').
int_to_char(21,'v').
int_to_char(22,'w').
int_to_char(23,'x').
int_to_char(24,'y').
int_to_char(25,'z').

head([H|_],H).
tail([_|T],T).
empty([]).

my_succ(X,Y):- integer(X), Z is X+1, Y is Z mod 25. 

my_pred(0,25).
my_pred(X,Y):- integer(X), Y is X-1. 





ho_1(A,B,P) :- P(A,C),P(C,D),P(D,E),P(E,F),P(F,B)
addlast5(A,B) :- ho_1(A,B,addlast1)
addhead5(A,B) :- ho_1(A,B,addhead1)
duplheadk5(A,B) :- ho_1(A,B,duplhead)
repeatminushead5(A,B) :- ho_1(A,B,minushead1)
repeatminuslast5(A,B) :- ho_1(A,B,minuslast1)
dropfirst5(A,B) :- ho_1(A,B,tail)
ho_14(A,P,Q,R) :- P(A)
ho_14(A,P,Q,R) :- head(A,B),Q(A,C),R(B),ho_14(C,P,Q,R)
allpositiveallodd(A) :- ho_14(A,empty,tail,odd)
allnegative(A) :- ho_14(A,empty,tail,negative)
allone(A) :- ho_14(A,empty,tail,one_in)
allzero(A) :- ho_14(A,empty,tail,zero_in)
allpositive(A) :- ho_14(A,empty,tail,positive)
ho_54(A,B,P,Q,R) :- P(A),P(B)
ho_54(A,B,P,Q,R) :- Q(A,C),tail(A,D),Q(B,E),tail(B,F),R(C,E),ho_54(D,F,P,Q,R)
maptimestwo(A,B) :- ho_54(A,B,empty,head,double)
mapcube(A,B) :- ho_54(A,B,empty,head,cube)
mapminusone(A,B) :- ho_54(A,B,empty,head,decrement)
chartoint(A,B) :- ho_54(A,B,empty,head,ord)
mapsquare(A,B) :- ho_54(A,B,empty,head,square)
inttobin(A,B) :- ho_54(A,B,empty,head,bin)
maptimesthree(A,B) :- ho_54(A,B,empty,head,triple)
ho_68(A,B,P,Q) :- empty(A),P(B)
ho_68(A,B,P,Q) :- head(A,C),tail(A,D),ho_68(D,E,P,Q),Q(C,E,B)
sum_list(A,B) :- ho_68(A,B,zero,sum)
orlist(A,B) :- ho_68(A,B,zero,or_element)
maxlist(A,B) :- ho_68(A,B,zero,max)
andlist(A,B) :- ho_68(A,B,one,and_element)
ho_121(A,B,P,Q,R) :- P(A,B),Q(B,C),R(C)
ho_121(A,B,P,Q,R) :- P(A,C),ho_121(C,B,P,Q,R)
rotateuntilone(A,B) :- ho_121(A,B,rotate1,head,one)
decrement1until(A,B) :- ho_121(A,B,decrementhead1,head,zero_in)
dropuntileven(A,B) :- ho_121(A,B,tail,head,even)
dropuntilodd(A,B) :- ho_121(A,B,tail,head,odd)
doubleheaduntil(A,B) :- ho_121(A,B,doublehead,head,c128)
squareheaduntil(A,B) :- ho_121(A,B,squarehead,head,c256)
ho_155(A,B,P,Q,R) :- empty(A),empty(B)
ho_155(A,B,P,Q,R) :- P(A,C,D),Q(C),ho_155(D,B,P,Q,R)
ho_155(A,B,P,Q,R) :- P(A,C,D),R(C),ho_155(D,E,P,Q,R),cons(C,E,B)
filter_odd(A,B) :- ho_155(A,B,cons3,odd,even)
filter_positive(A,B) :- ho_155(A,B,cons3,positive,negative)
filter_even(A,B) :- ho_155(A,B,cons3,even,odd)
filter_zero(A,B) :- ho_155(A,B,cons3,zero_in,one_in)
filter_negative(A,B) :- ho_155(A,B,cons3,negative,positive)
ho_172(A,P,Q,R) :- P(A,B),Q(B)
ho_172(A,P,Q,R) :- R(A,B),ho_172(B,P,Q,R)
memberzero(A) :- ho_172(A,head,zero_in,tail)
memberminusone(A) :- ho_172(A,head,minusone,tail)
memberodd(A) :- ho_172(A,head,odd,tail)
membereven(A) :- ho_172(A,head,even,tail)
ho_180(A,B,C,P,Q) :- zero_in(A),eq_list(B,C)
ho_180(A,B,C,P,Q) :- P(A,D),ho_180(D,B,E,P,Q),Q(E,C)
iterateaddheadk(A,B,C) :- ho_180(A,B,C,decrement,addhead1)
iterateaddlastk(A,B,C) :- ho_180(A,B,C,decrement,addlast1)
iteratedecrementheadk(A,B,C) :- ho_180(A,B,C,decrement,decrementhead1)
iteraterepeatN(A,B,C) :- ho_180(A,B,C,decrement,duplhead)
ho_199(A,B,P,Q) :- empty(A),zero_int(B)
ho_199(A,B,P,Q) :- head(A,C),tail(A,D),P(C),ho_199(D,B,P,Q)
ho_199(A,B,P,Q) :- head(A,C),tail(A,D),Q(C),ho_199(D,E,P,Q),my_increment(E,B)
count_positive(A,B) :- ho_199(A,B,negative,positive)
count_zero(A,B) :- ho_199(A,B,one,zero_in)
count_negative(A,B) :- ho_199(A,B,positive,negative)
count_even(A,B) :- ho_199(A,B,odd,even)
count_one(A,B) :- ho_199(A,B,zero_in,one)
ho_438(A,P,Q,R) :- P(A,B),empty(B)
ho_438(A,P,Q,R) :- Q(A,B),P(A,C),ho_438(C,P,Q,R),Q(C,D),R(B,D)
sorted_triple(A) :- ho_438(A,tail,head,my_triple)
sorted_double(A) :- ho_438(A,tail,head,my_double)
alltwo(A) :- empty(A)
alltwo(A) :- head(A,B),tail(A,C),decrement(B,D),one_in(D),alltwo(C)
addlast5(A,B) :- addlast1(A,C),addlast1(C,D),addlast1(D,E),addlast1(E,F),addlast1(F,B)
addhead5(A,B) :- addhead1(A,C),addhead1(C,D),addhead1(D,E),addhead1(E,F),addhead1(F,B)
dropuntilthree(A,B) :- tail(A,B),head(B,C),decrement(C,D),decrement(D,E),one_in(E)
dropuntilthree(A,B) :- tail(A,C),dropuntilthree(C,B)
duplheadk5(A,B) :- duplhead(A,C),duplhead(C,D),duplhead(D,E),duplhead(E,F),duplhead(F,B)
iteratedropk(A,B,C) :- zero_in(A),eq_list(B,C)
iteratedropk(A,B,C) :- decrement(A,D),tail(B,E),iteratedropk(D,E,C)
multlist(A,B) :- empty(A),one(B)
multlist(A,B) :- head(A,C),tail(A,D),multlist(D,E),mult(E,C,B)
membertwo(A) :- head(A,B),decrement(B,C),one_in(C)
membertwo(A) :- tail(A,B),membertwo(B)
repeatminushead5(A,B) :- minushead1(A,C),minushead1(C,D),minushead1(D,E),minushead1(E,F),minushead1(F,B)
repeatminuslast5(A,B) :- minuslast1(A,C),minuslast1(C,D),minuslast1(D,E),minuslast1(E,F),minuslast1(F,B)
memberthree(A) :- head(A,B),decrement(B,C),decrement(C,D),one_in(D)
memberthree(A) :- tail(A,B),memberthree(B)
allpositivememberone(A) :- head(A,B),tail(A,C),one_in(B),head(C,D),odd(D)
allpositivememberone(A) :- head(A,B),tail(A,C),even(B),head(C,D),one_in(D)
allpositivememberone(A) :- head(A,B),tail(A,C),positive(B),allpositivememberone(C)
alloddmemberone(A) :- head(A,B),one_in(B)
alloddmemberone(A) :- tail(A,B),alloddmemberone(B),head(B,C),odd(C)
memberfour(A) :- head(A,B),decrement(B,C),decrement(C,D),decrement(D,E),one_in(E)
memberfour(A) :- tail(A,B),memberfour(B)
dropfirst5(A,B) :- tail(A,C),tail(C,D),tail(D,E),tail(E,F),tail(F,B)

 stevie time 30.855289708
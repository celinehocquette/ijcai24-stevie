ho_5(A,B,P,Q) :- P(A,B),head(B,C),Q(C)
ho_5(A,B,P,Q) :- P(A,C),ho_5(C,B,P,Q)
dropuntileven(A,B) :- ho_5(A,B,tail,even)
rotateuntilone(A,B) :- ho_5(A,B,rotate1,one)
dropuntilodd(A,B) :- ho_5(A,B,tail,odd)
squareheaduntil(A,B) :- ho_5(A,B,squarehead,c256)
ho_12(A,P) :- tail(A,B),empty(B)
ho_12(A,P) :- head(A,B),tail(A,C),ho_12(C,P),head(C,D),P(B,D)
increment_seq(A) :- ho_12(A,incrementin)
decrement_seq(A) :- ho_12(A,decrementin)
sorted_decr(A) :- ho_12(A,geq)
sorted_double(A) :- ho_12(A,my_double)
ho_109(A,B,P,Q) :- empty(A),P(B)
ho_109(A,B,P,Q) :- head(A,C),tail(A,D),ho_109(D,E,P,Q),Q(C,E,B)
multlist(A,B) :- ho_109(A,B,one,mult)
sum_list(A,B) :- ho_109(A,B,zero,sum)
ho_155(A,B,P,Q) :- empty(A),zero_int(B)
ho_155(A,B,P,Q) :- head(A,C),tail(A,D),P(C),ho_155(D,B,P,Q)
ho_155(A,B,P,Q) :- head(A,C),tail(A,D),Q(C),ho_155(D,E,P,Q),my_increment(E,B)
count_zero(A,B) :- ho_155(A,B,one,zero_in)
count_odd(A,B) :- ho_155(A,B,even,odd)
count_positive(A,B) :- ho_155(A,B,negative,positive)
count_one(A,B) :- ho_155(A,B,zero_in,one)
ho_251(A,B,P) :- empty(A),empty(B)
ho_251(A,B,P) :- head(A,C),tail(A,D),head(B,E),tail(B,F),P(C,E),ho_251(D,F,P)
mapaddone(A,B) :- ho_251(A,B,increment)
mapsquare(A,B) :- ho_251(A,B,square)
maptimesthree(A,B) :- ho_251(A,B,triple)
mapminusone(A,B) :- ho_251(A,B,decrement)
ho_273(A,B,P,Q) :- empty(A),empty(B)
ho_273(A,B,P,Q) :- cons3(A,C,D),P(C),ho_273(D,B,P,Q)
ho_273(A,B,P,Q) :- cons3(A,C,D),Q(C),ho_273(D,E,P,Q),cons(C,E,B)
filter_odd(A,B) :- ho_273(A,B,odd,even)
filter_even(A,B) :- ho_273(A,B,even,odd)
ho_288(A,P) :- head(A,B),P(B)
ho_288(A,P) :- tail(A,B),ho_288(B,P)
memberodd(A) :- ho_288(A,odd)
memberzero(A) :- ho_288(A,zero_in)
ho_317(A,P) :- empty(A)
ho_317(A,P) :- head(A,B),tail(A,C),P(B),ho_317(C,P)
allpositive(A) :- ho_317(A,positive)
allodd(A) :- ho_317(A,odd)
allzero(A) :- ho_317(A,zero_in)
ho_378(A,B,P,Q) :- empty(A),P(B)
ho_378(A,B,P,Q) :- head(A,C),tail(A,D),ho_378(D,E,P,Q),Q(E,C,B)
maxlist(A,B) :- ho_378(A,B,one,max)
orlist(A,B) :- ho_378(A,B,zero,or_element)
minlist(A,B) :- ho_378(A,B,c100,min)
ho_499(A,B,C,P) :- zero_in(A),eq_list(B,C)
ho_499(A,B,C,P) :- decrement(A,D),ho_499(D,B,E,P),P(E,C)
iteraterepeatN(A,B,C) :- ho_499(A,B,C,duplhead)
iteratedecrementheadk(A,B,C) :- ho_499(A,B,C,decrementhead1)
iterateaddheadk(A,B,C) :- ho_499(A,B,C,addhead1)
dropfirst5(A,B) :- tail(A,C),tail(C,D),tail(D,E),tail(E,F),tail(F,B)
memberfour(A) :- head(A,B),decrement(B,C),decrement(C,D),decrement(D,E),one_in(E)
memberfour(A) :- tail(A,B),memberfour(B)
membertwo(A) :- head(A,B),decrement(B,C),one_in(C)
membertwo(A) :- tail(A,B),membertwo(B)
memberthree(A) :- head(A,B),decrement(B,C),decrement(C,D),one_in(D)
memberthree(A) :- tail(A,B),memberthree(B)
allthree(A) :- empty(A)
allthree(A) :- head(A,B),tail(A,C),decrement(B,D),allthree(C),decrement(D,E),one_in(E)
dropuntilthree(A,B) :- tail(A,B),head(B,C),decrement(C,D),decrement(D,E),one_in(E)
dropuntilthree(A,B) :- tail(A,C),dropuntilthree(C,B)
iteratedropk(A,B,C) :- zero_in(A),eq_list(B,C)
iteratedropk(A,B,C) :- decrement(A,D),tail(B,E),iteratedropk(D,E,C)
memberfive(A) :- head(A,B),decrement(B,C),decrement(C,D),decrement(D,E),decrement(E,F),one_in(F)
memberfive(A) :- tail(A,B),memberfive(B)
filter_one(A,B) :- empty(A),empty(B)
filter_one(A,B) :- cons3(A,C,D),one_in(C),filter_one(D,B)
filter_one(A,B) :- cons3(A,C,D),filter_one(D,E),cons(C,E,B)
twomembers_1_2(A) :- tail(A,B),tail(B,C),head(C,D),one(D)
twomembers_1_2(A) :- head(A,B),tail(A,C),odd(B),twomembers_1_2(C)
twomembers_1_2(A) :- head(A,B),tail(A,C),decrement(B,D),odd(D),twomembers_1_2(C)

 stevie time 277.0105434509969
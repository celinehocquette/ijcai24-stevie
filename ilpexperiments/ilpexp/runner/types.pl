
body_pred(c256,1).
type(c256,(element,)).
direction(c256,(in,)).


body_pred(doublehead,2).
type(doublehead,(list,list)).
direction(doublehead,(in,out)).
body_pred(c128,1).
type(c128,(element,)).
direction(c128,(in,)).
body_pred(c4096,1).
type(c4096,(element,)).
direction(c4096,(in,)).
body_pred(squarehead,2).
type(squarehead,(list,list)).
direction(squarehead,(in,out)).
body_pred(c65536,1).
type(c65536,(element,)).
direction(c65536,(in,)).

body_pred(int,1).
type(int,(element,)).
direction(int,(in,)).

body_pred(decrement_int,2).
type(decrement_int,(int,int)).
direction(decrement_int,(in,out)).

body_pred(minuslast1,2).
type(minuslast1,(list,list)).
direction(minuslast1,(in,out)).

body_pred(minushead1,2).
type(minushead1,(list,list)).
direction(minushead1,(in,out)).

body_pred(minusone,1).
type(minusone,(element,)).
direction(minusone,(in,)).

body_pred(square,2).
type(square,(element,element)).
direction(square,(in,out)).
type(cons,(element,list,list)).
type(head,(list,element)).
type(tail,(list,list)).
type(rotate1,(list,list)).
type(empty,(list,)).
type(element,(list,element)).
type(my_succ,(element,element)).
type(increment,(element,element)).
type(decrement,(element,element)).
type(incrementin,(element,element)).
type(decrementin,(element,element)).
type(geq,(element,element)).
type(leq,(element,element)).
type(even,(element,)).
type(odd,(element,)).
type(one,(element,)).
type(zero,(element,)).
type(sum,(element,element,element)).
type(mult,(element,element,element)).

type(c100,(element,)).

type(countone,(list,element)).

type(xorlist,(list,element)).
type(comps,(list, element, list)).
type(xor,(element, element, element)).

type(ifodddoubleelsetriple,(element, element)).
type(double,(element, element)).
type(triple,(element, element)).

type(my_double,(element, element)).
type(my_triple,(element, element)).

type(next,(list,element,element)).

type(increment_seq,(list,)).
type(head,(list, element)).
type(tail,(list, list)).

type(eq,(list,list)).

type(appendlist,(list, list, list)).
type(consend,(element, list, list)).
type(eq,(list, list)).

type(takeuntilpositive,(list,list)).
type(eq,(list,list)).

type(countpositive,(list,element)).
type(negative,(element,)).
type(positive,(element,)).

type(countodd,(list,element)).

type(membereven,(list,)).

type(sorted_incr,(list,)).
type(head,(list, element)).
type(tail,(list, list)).

type(last,(list, element)).

type(multlist,(list, element)).

type(sum_list,(list, element)).

type(addsuccessivelist,(list, list)).

type(alleven,(list,)).

type(everyoddindex,(list, list)).

type(decrement_seq,(list,)).
type(head,(list, element)).
type(tail,(list, list)).

type(lastbutone,(list, element)).

type(member,(list,element)).

type(swap,(list, list)).

type(modulo2,(list, list)).
type(mod2,(element, element)).

type(threesucc,(list,)).

type(takeuntileven,(list,list)).
type(eq,(list,list)).

type(factorial,(element,element)).

type(countzero,(list,element)).

type(eq,(list,list)).

type(takeuntilpositive,(list,list)).
type(eq,(list,list)).

type(ifpostiveeqelsezero,(element, element)).
type(eq,(element, element)).
type(positive,(element,)).

type(takeuntilnegative,(list,list)).
type(eq,(list,list)).

type(sorted_decr,(list,)).
type(head,(list, element)).
type(tail,(list, list)).

type(countnegative,(list,element)).
type(negative,(element,)).
type(positive,(element,)).

type(rotate1,(list, list)).
type(cons2,(list,element,list)).

type(maxlist,(list, element)).
type(max,(element,element,element)).
type(comps,(list, element, list)).

type(reverse,(list, list)).
type(cons2,(list,element,list)).

type(ifoddadd1elseeq,(element, element)).
type(eq,(element, element)).
type(my_succ,(element, element)).

type(maxnumbers,(element, element, element)).
type(eq,(element,element)).

type(allone,(list,)).

type(allzero,(list,)).

type(memberodd,(list,)).

type(bin,(element,element)).
type(comps,(list, element, list)).

type(threesame,(list,)).

type(eq,(list,list)).

type(takeuntilodd,(list,list)).
type(eq,(list,list)).

type(duplicate,(list, list)).

type(absolutevalue,(element, element)).
type(changesign,(element, element)).
type(positive,(element,)).
type(eq,(element, element)).

type(memberone,(list,)).


type(filter_gt_head,(list, list)).

type(add,(element, element, element)).
type(my_succ,(element, element)).

type(eq,(list,list)).

type(allodd,(list,)).

type(finddup,(list, element)).

type(odds,(list,)).

type(memberzero,(list,)).

type(allequal,(list,)).

type(sum2lists,(list, list, list)).
type(comps,(list, element, list)).
type(cons,(element, list, list)).

type(len,(list,element)).

type(addthree,(list, list)).
type(my_succ,(element, element)).

type(replace,(list, element, element, list)).

type(ifpostiveoneelsezero,(element, element)).
type(positive,(element,)).

type(sum1n,(element,element)).

type(eq,(list,list)).

type(chartoint,(list, list)).
type(ord,(element,element)).
type(comps,(list, element, list)).

type(sublist,(list, list)).
type(eq,(list, list)).

type(eq,(list,list)).

type(filter_negative,(list, list)).
type(negative,(element,)).
type(positive,(element,)).

type(counteven,(list,element)).

type(addhead,(list, list)).

type(addhead,(list, list)).

type(addone,(list, list)).
type(my_succ,(element, element)).
type(comps,(list, element, list)).
type(my_succ,(element, element)).

type(evens,(list,)).

type(minnumbers,(element, element, element)).
type(eq,(element,element)).

type(droplast,(list,list)).

type(addhead,(list, list)).

type(addtwo,(list, list)).
type(my_succ,(element, element)).

type(minlist,(list, element)).
type(min,(element,element,element)).
type(comps,(list, element, list)).

type(ifevenoneelsezero,(element, element)).

type(multsuccessivelist,(list, list)).

body_pred(my_decrement,2).
type(my_decrement,(int,int)).
direction(my_decrement,(in,out)).

body_pred(my_increment,2).
type(my_increment,(int,int)).
direction(my_increment,(in,out)).

body_pred(zero_int,1).
type(zero_int,(int,)).
direction(zero_int,(in,)).

body_pred(addhead1,2).
type(addhead1,(list,list)).
direction(addhead1,(in,out)).

body_pred(addlast1,2).
type(addlast1,(list,list)).
direction(addlast1,(in,out)).

body_pred(duplhead,2).
type(duplhead,(list,list)).
direction(duplhead,(in,out)).

body_pred(cube,2).
type(cube,(element,element)).
direction(cube,(in,out)).


enable_recursion.

type(allequal,(list,)).
type(alleven,(list,)).
type(allodd,(list,)).
type(allone,(list,)).
type(allzero,(list,)).
type(appendlist(list,list,list)).
type(consend,(element, list, list)).
type(ord,(element,element)).
type(comps,(list, element, list)).
type(chartoint,(list, list)).
type(counteven,(list,element)).
type(countnegative,(list,element)).
type(counteven,(list,element)).
type(countodd,(list,element)).
type(countone,(list,element)).
type(countpositive,(list,element)).
type(countzero,(list,element)).
type(allone,(list,)).
type(memberone,(list,element)).
type(membereven,(list,element)).
type(memberodd,(list,element)).
type(addone,(list,list)).
type(absolutevalue,(element, element)).
type(changesign,(element, element)).
body_pred(positive,1).
type(positive,(element,)).
type(negative,(element,)).
type(eq,(element, element)).
type(eq_list,(list, list)).
type(one,(element,)).
type(zero,(element,)).
type(zero_in,(element,)).
type(bin,(element,element)).
type(my_succ,(element, element)).
type(add,(element, element, element)).
type(addhead,(list, list)).
type(addheadone,(list, list)).
type(addheadzero,(list, list)).
type(addone,(list, list)).
type(addtwo,(list, list)).
type(addthree,(list, list)).
type(addsuccessivelist,(list, list)).
type(decrement_seq,(list,)).
type(decrement_seq,(list,)).


type(duplicate,(list,list)).
type(evens,(list,)).
type(everyoddindex,(list, list)).
type(factorial,(element,element)).
type(filter_gt_head,(list, list)).
type(filter_negative,(list, list)).
type(finddup,(list, element)).
type(cons,(element,list,list)).

body_pred(inttochar,2).
type(inttochar,(element,element)).
direction(inttochar,(in,out)).

type(decrementhead1,(list,list)).
direction(decrementhead1,(in,out)).

body_pred(cons3,3).
type(cons3,(list,element,list)).
direction(cons3,(in,out,out)).

direction(cons,(in,in,out)).
direction(head,(in,out)).
direction(tail,(in,out)).
direction(empty,(in,)).
direction(element,(in,out)).
direction(my_succ,(in,out)).
direction(increment,(in,out)).
direction(decrement,(in,out)).

direction(incrementin,(in,in)).
direction(decrementin,(in,in)).
direction(geq,(in,in)).
direction(leq,(in,in)).
direction(even,(in,)).
direction(odd,(in,)).
direction(one,(in,)).
direction(c100,(in,)).
direction(zero,(out,)).
direction(zero_in,(in,)).
direction(sum,(in,in,out)).
direction(mult,(in,in,out)).

body_pred(one_in,1).
type(one_in,(element,)).
direction(one_in,(in,)).


direction(countone,(in,out)).

direction(xorlist,(in,out)).
direction(comps,(in,out,out)).
direction(xor,(in,in,out)).

direction(ifodddoubleelsetriple,(in,out)).
direction(double,(in,out)).
direction(triple,(in,out)).
direction(my_double,(in,in)).
direction(my_triple,(in,in)).

direction(next,(in,in,out)).
direction(increment_seq,(in,)).
direction(head,(in,out)).
direction(tail,(in,out)).

direction(eq_list,(in,out)).

direction(appendlist,(in, in, out)).
direction(consend,(in, in, out)).
direction(eq,(in, out)).

direction(takeuntilpositive,(in,out)).
direction(eq,(in,out)).

direction(countpositive,(in,out)).
direction(negative,(in,)).
direction(positive,(in,)).

direction(countodd,(in,out)).

direction(membereven,(in,)).

direction(sorted_incr,(in,)).
direction(head,(in,out)).
direction(tail,(in,out)).

direction(last,(in,out)).

direction(multlist,(in,out)).

direction(sum_list,(in,out)).

direction(addsuccessivelist,(in,out)).

direction(alleven,(in,)).
direction(everyoddindex,(in,out)).

direction(decrement_seq,(in,)).
direction(head,(in,out)).
direction(tail,(in,out)).

direction(lastbutone,(in,out)).
direction(member,(in,out)).

direction(swap,(in,out)).

direction(modulo2,(in,out)).
direction(mod2,(in,out)).
direction(threesucc,(in,)).
direction(rotate1,(in,out)).

direction(takeuntileven,(in,out)).
direction(eq,(in,out)).

direction(factorial,(in,out)).

direction(countzero,(in,out)).

direction(eq,(in,out)).

direction(takeuntilpositive,(in,out)).
direction(eq,(in,out)).

direction(ifpostiveeqelsezero,(in,out)).
direction(eq,(in,out)).
direction(positive,(in,)).

direction(takeuntilnegative,(in,out)).
direction(eq,(in,out)).

direction(sorted_decr,(in,)).
direction(head,(in,out)).
direction(tail,(in,out)).

direction(countnegative,(in,out)).
direction(negative,(in,)).
direction(positive,(in,)).

direction(rotate1,(in,out)).
direction(cons2,(in,in,out)).

direction(maxlist,(in,out)).
direction(max,(in,in,out)).
direction(comps,(in,out,out)).

direction(reverse,(in,out)).
direction(cons2,(in,in,out)).

direction(ifoddadd1elseeq,(in,out)).
direction(eq,(in,out)).
direction(my_succ,(in,out)).

direction(maxnumbers,(in,in,out)).
direction(eq,(in,out)).

direction(allone,(in,)).
direction(allzero,(in,)).
direction(memberodd,(in,)).

direction(bin,(in,out)).
direction(comps,(in,out,out)).

direction(threesame,(in,)).

direction(eq,(in,out)).

direction(takeuntilodd,(in,out)).
direction(eq,(in,out)).

direction(duplicate,(in,out)).

direction(absolutevalue,(in,out)).
direction(changesign,(in,out)).
direction(positive,(in,)).
direction(eq,(in,out)).

direction(memberone,(in,)).


direction(filter_gt_head,(in,out)).

direction(add,(in,in,out)).
direction(my_succ,(in,out)).

direction(eq,(in,out)).

direction(allodd,(in,)).
direction(finddup,(in,out)).

direction(odds,(in,)).

direction(memberzero,(in,)).

direction(allequal,(in,)).
direction(sum2lists,(in,in,out)).
direction(comps,(in,out,out)).
direction(cons,(in,in,out)).

direction(len,(in,out)).

direction(addthree,(in, out)).
direction(my_succ,(in,out)).

direction(replace,(in,in,in,out)).

direction(ifpostiveoneelsezero,(in,out)).
direction(positive,(in,)).

direction(sum1n,(in,out)).

direction(eq,(in,out)).

direction(chartoint,(in,in)).
direction(ord,(in,out)).
direction(comps,(in,out,out)).

direction(sublist,(in, in)).
direction(eq,(in, out)).

direction(eq,(in,out)).

direction(filter_negative,(in,out)).
direction(negative,(in,)).
direction(positive,(in,)).

direction(counteven,(in,out)).

direction(addhead,(in,out)).

direction(addhead,(in,out)).

direction(addone,(in, out)).
direction(my_succ,(in,out)).
direction(comps,(in,out,out)).
direction(my_succ,(in,out)).

direction(dropk,(in,in,out)).

direction(evens,(in,)).

direction(minnumbers,(in,in,out)).
direction(eq,(in,out)).

direction(droplast,(in,out)).

direction(addhead,(in,out)).

direction(addtwo,(in, out)).
direction(my_succ,(in,out)).

direction(minlist,(in,out)).
direction(min,(in,in,out)).
direction(comps,(in,out,out)).

direction(ifevenoneelsezero,(in,out)).

direction(multsuccessivelist,(in,out)).



type(draw1,(state,state)).
type(draw0,(state,state)).
type(move_right,(state,state)).
type(move_left,(state,state)).
type(move_up,(state,state)).
type(move_down,(state,state)).
type(at_top,(state,)).
type(at_bottom,(state,)).
type(at_left,(state,)).
type(at_right,(state,)).
type(neg_at_top,(state,)).
type(neg_at_bottom,(state,)).
type(neg_at_left,(state,)).
type(neg_at_right,(state,)).

direction(draw1,(in,out)).
direction(draw0,(in,out)).
direction(move_right,(in,out)).
direction(move_left,(in,out)).
direction(move_up,(in,out)).
direction(move_down,(in,out)).
direction(at_top,(in,)).
direction(at_bottom,(in,)).
direction(at_left,(in,)).
direction(at_right,(in,)).
direction(neg_at_top,(in,)).
direction(neg_at_bottom,(in,)).
direction(neg_at_left,(in,)).
direction(neg_at_right,(in,)).


type(is_empty,(string,)).
type(neg_empty,(string,)).
type(is_space,(string,)).
type(neg_space,(string,)).
type(is_uppercase,(string,)).
type(is_lowercase,(string,)).
type(is_letter,(string,)).
type(neg_letter,(string,)).
type(is_number,(string,)).
type(neg_number,(string,)).
type(copy1,(string,string)).
type(skip1,(string,string)).
type(mk_uppercase,(string,string)).
type(mk_lowercase,(string,string)).
%type(write1,(string,string,string)).
type(skiprest,(string,string)).
type(copyrest,(string,string)).

direction(is_empty,(in,)).
direction(neg_empty,(in,)).
direction(is_space,(in,)).
direction(neg_space,(in,)).
direction(is_uppercase,(in,)).
direction(is_lowercase,(in,)).
direction(is_letter,(in,)).
direction(neg_letter,(in,)).
direction(is_number,(in,)).
direction(neg_number,(in,)).
direction(copy1,(in,out)).
direction(skip1,(in,out)).
direction(mk_uppercase,(in,out)).
direction(mk_lowercase,(in,out)).
%direction(write1,(in,out,out)).
direction(skiprest,(in,out)).
direction(copyrest,(in,out)).


body_pred(or_element,3).
type(or_element,(element, element, element)).
direction(or_element,(in,in,out)).

body_pred(and_element,3).
type(and_element,(element, element, element)).
direction(and_element,(in,in,out)).

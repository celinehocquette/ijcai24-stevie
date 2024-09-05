body_pred(include,3,ho).
type(include,(list,list,(element,))).
direction(exclude,(in,out,(in,))).

body_pred(exclude,3,ho).
type(exclude,(list,list,(element,))).
direction(exclude,(in,out,(in,))).

body_pred(maplist,3,ho).
type(maplist,(list,list,(element,element))).
direction(maplist,(in,out,(in,out))).

body_pred(convlist,3,ho).
type(convlist,(list,list,(element,element))).
direction(convlist,(in,out,(in,out))).

body_pred(foldl,4,ho).
type(foldl,(list,element,element,(element,element,element))).
direction(foldl,(in,in,out,(in,in,out))).

body_pred(partition,4,ho).
type(partition,(list,list,list,(element,))).
direction(partition,(in,out,out,(in,))).

body_pred(scanl,4,ho).
type(scanl,(list,element,list,(element,element,element))).
direction(scanl,(in,in,out,(in,in,out))).

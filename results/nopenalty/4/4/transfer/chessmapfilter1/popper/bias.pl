head_pred(chessmapfilter1,2).
type(chessmapfilter1,(state, state)).
direction(chessmapfilter1,(in,in)).



max_vars(3).
max_body(2).
max_clauses(4).


body_pred(forward,2).
body_pred(back,2).

body_pred(empty,1).
body_pred(pawn,1).
body_pred(neg_pawn,1).
body_pred(rook,1).
body_pred(neg_rook,1).
body_pred(rank8,1).
body_pred(neg_rank8,1).

%body_pred(cons1,3).
%body_pred(cons2,3).

type(forward,(element,element)).
direction(forward,(in,out)).
type(back,(element,element)).
direction(back,(in,out)).
direction(cons1,(in,in,out)).
direction(cons2,(out,out,in)).
type(empty,(state,)).
direction(empty,(in,)).

body_pred(cons3,3).
type(cons3,(state,element,state)).
direction(cons3,(in,out,out)).


body_pred(head,2).
type(head,(state,element)).
direction(head,(in,out)).
body_pred(tail,2).
type(tail,(state,state)).
direction(tail,(in,out)).

type(hold,(element,element)).
direction(hold,(in,out)).
type(rank8,(element,)).
direction(rank8,(in,)).
type(neg_rank8,(element,)).
direction(neg_rank8,(in,)).
type(pawn,(element,)).
direction(pawn,(in,)).
type(neg_pawn,(element,)).
direction(neg_pawn,(in,)).
type(rook,(element,)).
direction(rook,(in,)).
type(neg_rook,(element,)).
direction(neg_rook,(in,)).

enable_recursion.




body_pred(ho_172,4,ho).
body_pred(ho_438,4,ho).
body_pred(ho_14,4,ho).
body_pred(ho_121,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_54,5,ho).
body_pred(ho_68,4,ho).
type(ho_1,(state, state, (state, state))).
type(ho_14,(state, (state, ), (state, state), (element, ))).
type(ho_54,(state, state, (state, ), (state, element), (element, element))).
type(ho_68,(state, element, (element, ), (element, element, element))).
type(ho_121,(state, state, (state, state), (state, element), (element, ))).
type(ho_155,(state, state, (state, element, state), (element, ), (element, ))).
type(ho_172,(state, (state, element), (element, ), (state, state))).
type(ho_180,(element, state, state, (element, element), (state, state))).
type(ho_199,(state, element, (element, ), (element, ))).
type(ho_438,(state, (state, state), (state, element), (element, element))).
direction(ho_1,(in, out, (in, out))).
direction(ho_14,(in, (in, ), (in, out), (in, ))).
direction(ho_54,(in, in, (in, ), (in, out), (in, out))).
direction(ho_68,(in, out, (in, ), (in, in, out))).
direction(ho_121,(in, out, (in, out), (in, out), (in, ))).
direction(ho_155,(in, out, (in, out, out), (in, ), (in, ))).
direction(ho_172,(in, (in, out), (in, ), (in, out))).
direction(ho_180,(in, in, out, (in, out), (in, out))).
direction(ho_199,(in, out, (in, ), (in, ))).
direction(ho_438,(in, (in, out), (in, out), (in, in))).



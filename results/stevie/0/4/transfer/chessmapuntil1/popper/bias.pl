head_pred(chessmapuntil1,2).
type(chessmapuntil1,(state, state)).
direction(chessmapuntil1,(in,in)).




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




body_pred(ho_185,3,ho).
body_pred(ho_1,3,ho).
body_pred(ho_44,2,ho).
body_pred(ho_308,2,ho).
body_pred(ho_6,2,ho).
body_pred(ho_251,4,ho).
body_pred(ho_101,4,ho).
type(ho_1,(state, state, (state, state))).
type(ho_6,(state, (element, ))).
type(ho_16,(element, state, state, (state, state))).
type(ho_44,(state, (element, ))).
type(ho_101,(state, element, (element, ), (element, element, element))).
type(ho_132,(state, element, (element, ), (element, ))).
type(ho_185,(state, state, (element, element))).
type(ho_251,(state, state, (state, state), (element, ))).
type(ho_308,(state, (element, element))).
type(ho_489,(state, state, (element, ), (element, ))).
direction(ho_1,(in, out, (in, out))).
direction(ho_6,(in, (in, ))).
direction(ho_16,(in, in, out, (in, out))).
direction(ho_44,(in, (in, ))).
direction(ho_101,(in, out, (in, ), (in, in, out))).
direction(ho_132,(in, out, (in, ), (in, ))).
direction(ho_185,(in, in, (in, out))).
direction(ho_251,(in, out, (in, out), (in, ))).
direction(ho_308,(in, (in, in))).
direction(ho_489,(in, out, (in, ), (in, ))).




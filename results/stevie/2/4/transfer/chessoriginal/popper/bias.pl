head_pred(chessoriginal,2).
type(chessoriginal,(state, state)).
direction(chessoriginal,(in,in)).


body_pred(hold,2).


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




body_pred(ho_65,2,ho).
body_pred(ho_21,4,ho).
body_pred(ho_48,4,ho).
body_pred(ho_26,2,ho).
body_pred(ho_194,2,ho).
body_pred(ho_1,3,ho).
body_pred(ho_143,3,ho).
type(ho_1,(state, state, (state, state))).
type(ho_5,(element, state, state, (state, state))).
type(ho_21,(state, state, (state, state), (element, ))).
type(ho_26,(state, (element, ))).
type(ho_48,(state, element, (element, ), (element, element, element))).
type(ho_65,(state, (element, element))).
type(ho_143,(state, state, (element, element))).
type(ho_176,(state, state, (element, ), (element, ))).
type(ho_194,(state, (element, ))).
type(ho_286,(state, element, (element, ), (element, ))).
direction(ho_1,(in, out, (in, out))).
direction(ho_5,(in, in, out, (in, out))).
direction(ho_21,(in, out, (in, out), (in, ))).
direction(ho_26,(in, (in, ))).
direction(ho_48,(in, out, (in, ), (in, in, out))).
direction(ho_65,(in, (in, in))).
direction(ho_143,(in, in, (in, out))).
direction(ho_176,(in, out, (in, ), (in, ))).
direction(ho_194,(in, (in, ))).
direction(ho_286,(in, out, (in, ), (in, ))).




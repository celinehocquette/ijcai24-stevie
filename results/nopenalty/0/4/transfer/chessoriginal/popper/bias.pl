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




body_pred(ho_355,5,ho).
body_pred(ho_445,4,ho).
body_pred(ho_238,4,ho).
body_pred(ho_222,2,ho).
body_pred(ho_141,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_22,5,ho).
body_pred(ho_160,3,ho).
type(ho_1,(state, state, (state, state))).
type(ho_22,(state, element, (state, ), (element, ), (element, element, element))).
type(ho_98,(state, element, (element, ), (element, ), (element, element))).
type(ho_141,(state, state, (state, element), (state, state), (element, element))).
type(ho_160,(state, (element, ), (state, state))).
type(ho_172,(element, state, state, (state, state))).
type(ho_222,(state, (element, ))).
type(ho_238,(state, state, (state, state), (element, ))).
type(ho_241,(element, state, state, (state, state))).
type(ho_355,(state, state, (element, ), (element, ), (element, state, state))).
type(ho_445,(state, (state, state), (state, element), (element, element))).
direction(ho_1,(in, out, (in, out))).
direction(ho_22,(in, out, (in, ), (in, ), (in, in, out))).
direction(ho_98,(in, in, (in, ), (in, ), (in, out))).
direction(ho_141,(in, in, (in, out), (in, out), (in, out))).
direction(ho_160,(in, (in, ), (in, out))).
direction(ho_172,(in, in, out, (in, out))).
direction(ho_222,(in, (in, ))).
direction(ho_238,(in, out, (in, out), (in, ))).
direction(ho_241,(in, in, out, (in, out))).
direction(ho_355,(in, in, (in, ), (in, ), (in, in, out))).
direction(ho_445,(in, (in, out), (in, out), (in, in))).




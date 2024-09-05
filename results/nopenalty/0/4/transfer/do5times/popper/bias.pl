
max_vars(5).
max_body(5).
max_ho(1).

head_pred(do5times,2).
type(do5times,(state, state)).
direction(do5times,(in,out)).




functional.

body_pred(draw1,2).
body_pred(draw0,2).
body_pred(move_right,2).
body_pred(move_left,2).
body_pred(move_up,2).
body_pred(move_down,2).
body_pred(at_top,1).
body_pred(at_bottom,1).
body_pred(at_left,1).
body_pred(at_right,1).
%body_pred(eq_list,2).
body_pred(head,2).
%body_pred(width,2).
%body_pred(height,2).

type(draw1,(state,state)).
type(draw0,(state,state)).
type(move_right,(state,state)).
type(move_left,(state,state)).
type(move_up,(state,state)).
type(move_down,(state,state)).
type(head,(state,position)).
type(at_top,(position,)).
type(at_bottom,(position,)).
type(at_left,(position,)).
type(at_right,(position,)).
type(eq_list,(state,state)).
type(width,(state,position)).
type(height,(state,position)).


direction(draw1,(in,out)).
direction(draw0,(in,out)).
direction(move_right,(in,out)).
direction(move_left,(in,out)).
direction(move_up,(in,out)).
direction(move_down,(in,out)).
direction(head,(in,out)).
direction(at_top,(in,)).
direction(at_bottom,(in,)).
direction(at_left,(in,)).
direction(at_right,(in,)).
direction(eq_list,(in,out)).
direction(width,(in,out)).
direction(height,(in,out)).

%enable_recursion.


body_pred(ho_238,4,ho).
body_pred(ho_1,3,ho).
body_pred(ho_160,3,ho).
type(ho_1,(state, state, (state, state))).
type(ho_22,(state, position, (state, ), (position, ), (position, position, position))).
type(ho_98,(state, position, (position, ), (position, ), (position, position))).
type(ho_141,(state, state, (state, position), (state, state), (position, position))).
type(ho_160,(state, (position, ), (state, state))).
type(ho_172,(position, state, state, (state, state))).
type(ho_222,(state, (position, ))).
type(ho_238,(state, state, (state, state), (position, ))).
type(ho_241,(position, state, state, (state, state))).
type(ho_355,(state, state, (position, ), (position, ), (position, state, state))).
type(ho_445,(state, (state, state), (state, position), (position, position))).
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




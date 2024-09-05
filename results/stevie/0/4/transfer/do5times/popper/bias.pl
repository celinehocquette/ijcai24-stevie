
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


body_pred(ho_1,3,ho).
body_pred(ho_251,4,ho).
type(ho_1,(state, state, (state, state))).
type(ho_6,(state, (position, ))).
type(ho_16,(position, state, state, (state, state))).
type(ho_44,(state, (position, ))).
type(ho_101,(state, position, (position, ), (position, position, position))).
type(ho_132,(state, position, (position, ), (position, ))).
type(ho_185,(state, state, (position, position))).
type(ho_251,(state, state, (state, state), (position, ))).
type(ho_308,(state, (position, position))).
type(ho_489,(state, state, (position, ), (position, ))).
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





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


body_pred(ho_329,5,ho).
body_pred(ho_1,3,ho).
body_pred(ho_15,5,ho).
body_pred(ho_8,4,ho).
type(ho_1,(state, state, (state, state))).
type(ho_8,(state, (state, position), (position, ), (state, state))).
type(ho_15,(state, state, (state, state), (state, position), (position, ))).
type(ho_42,(position, state, state, (position, ), (state, state), (state, state))).
type(ho_45,(state, (position, ))).
type(ho_180,(state, position, (position, ), (position, ), (position, position))).
type(ho_294,(state, state, (state, position, state), (position, ), (position, ))).
type(ho_329,(state, state, (state, ), (state, state), (position, position))).
type(ho_356,(state, position, (position, ), (position, position, position))).
type(ho_444,(state, (state, position), (position, position))).
direction(ho_1,(in, out, (in, out))).
direction(ho_8,(in, (in, out), (in, ), (in, out))).
direction(ho_15,(in, out, (in, out), (in, out), (in, ))).
direction(ho_42,(in, in, out, (in, ), (in, out), (in, out))).
direction(ho_45,(in, (in, ))).
direction(ho_180,(in, in, (in, ), (in, ), (in, out))).
direction(ho_294,(in, out, (in, out, out), (in, ), (in, ))).
direction(ho_329,(in, in, (in, ), (in, out), (in, out))).
direction(ho_356,(in, out, (out, ), (in, in, out))).
direction(ho_444,(in, (in, out), (in, in))).




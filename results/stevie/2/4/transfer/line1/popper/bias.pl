max_vars(4).
max_body(4).
max_clauses(2).
max_ho(1).
enable_recursion.

% line1(A,B):- ho_197(A,B,inv_ho_0,at_right).
% inv_ho_0(A,B):- draw0(A,C),move_right(C,B).


head_pred(line1,2).
type(line1,(state, state)).
direction(line1,(in,out)).






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


body_pred(ho_21,4,ho).
body_pred(ho_1,3,ho).
type(ho_1,(state, state, (state, state))).
type(ho_5,(position, state, state, (state, state))).
type(ho_21,(state, state, (state, state), (position, ))).
type(ho_26,(state, (position, ))).
type(ho_48,(state, position, (position, ), (position, position, position))).
type(ho_65,(state, (position, position))).
type(ho_143,(state, state, (position, position))).
type(ho_176,(state, state, (position, ), (position, ))).
type(ho_194,(state, (position, ))).
type(ho_286,(state, position, (position, ), (position, ))).
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




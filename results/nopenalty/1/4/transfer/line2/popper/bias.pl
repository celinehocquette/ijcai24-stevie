head_pred(line2,2).
type(line2,(state, state)).
direction(line2,(in,out)).


% line2(A,B):- until(A,C,inv_until_1_1,at_bottom), draw1(C,B).
% inv_until_1_1(A,B):- move_down(A,C), move_right(C,D), draw1(D,B).

max_vars(4).
max_body(3).
max_clauses(2).
max_ho(1).
enable_recursion.



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


body_pred(ho_19,4,ho).
body_pred(ho_405,4,ho).
body_pred(ho_1,3,ho).
type(ho_1,(state, state, (state, state))).
type(ho_19,(state, state, (state, state), (position, ))).
type(ho_33,(state, (position, ))).
type(ho_76,(position, state, state, (state, state), (state, state))).
type(ho_135,(state, state, (state, ), (state, position), (position, position))).
type(ho_138,(state, (position, ))).
type(ho_144,(position, state, state, (state, state))).
type(ho_213,(state, position, (position, ), (state, state), (position, position, position))).
type(ho_287,(state, position, (state, position), (position, ), (position, ))).
type(ho_405,(state, (state, state), (state, ), (position, position))).
type(ho_496,(state, state, (state, ), (position, ), (position, ))).
type(ho_610,(state, position, (state, ), (position, ), (position, position, position))).
direction(ho_1,(in, out, (in, out))).
direction(ho_19,(in, out, (in, out), (in, ))).
direction(ho_33,(in, (in, ))).
direction(ho_76,(in, in, out, (in, out), (in, out))).
direction(ho_135,(in, in, (in, ), (in, out), (in, out))).
direction(ho_138,(in, (in, ))).
direction(ho_144,(in, in, out, (in, out))).
direction(ho_213,(in, out, (in, ), (in, out), (in, in, out))).
direction(ho_287,(in, out, (in, out), (in, ), (in, ))).
direction(ho_405,(in, (in, out), (in, ), (in, in))).
direction(ho_496,(in, out, (in, ), (in, ), (in, ))).
direction(ho_610,(in, out, (in, ), (in, ), (in, in, out))).




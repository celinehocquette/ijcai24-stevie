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


body_pred(ho_13,3,ho).
body_pred(ho_8,5,ho).
body_pred(ho_1,3,ho).
type(ho_1,(state, state, (state, state))).
type(ho_8,(state, state, (state, state), (state, position), (position, ))).
type(ho_13,(state, (position, ), (state, state))).
type(ho_25,(state, (state, position), (position, ))).
type(ho_36,(position, state, state, (state, state), (state, state))).
type(ho_53,(state, (state, position), (position, position))).
type(ho_134,(state, position, (state, state), (position, ), (position, ))).
type(ho_187,(state, state, (state, ), (state, position), (position, position))).
type(ho_200,(position, state, state, (position, position), (state, state))).
type(ho_317,(state, position, (position, ), (position, position, position))).
type(ho_501,(state, state, (state, position, state), (position, ), (position, ))).
direction(ho_1,(in, out, (in, out))).
direction(ho_8,(in, out, (in, out), (in, out), (in, ))).
direction(ho_13,(in, (in, ), (in, out))).
direction(ho_25,(in, (in, out), (in, ))).
direction(ho_36,(in, in, out, (in, out), (in, out))).
direction(ho_53,(in, (in, out), (in, in))).
direction(ho_134,(in, out, (in, out), (in, ), (in, ))).
direction(ho_187,(in, in, (in, ), (in, out), (in, out))).
direction(ho_200,(in, in, out, (in, out), (in, out))).
direction(ho_317,(in, out, (out, ), (in, in, out))).
direction(ho_501,(in, out, (in, out, out), (in, ), (in, ))).




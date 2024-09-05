max_clauses(3).
max_vars(4).
max_body(3).
max_ho(1).


%waiter(A,B) :- until(A,B,f,at_end).
%f1(A,B) :- turn_cup_over(A,C), pour_tea(C,D), move_right(D,B).


head_pred(waiter,2).
body_pred(head,2).
body_pred(at_end,1).
body_pred(pour_tea,2).
body_pred(turn_cup_over,2).
body_pred(move_right,2).

type(waiter,(state, state)).
type(head,(state, position)).
type(wants_tea,(state,)).
type(wants_coffee,(state,)).
type(at_end,(position,)).
type(pour_tea,(state,state)).
type(pour_coffee,(state,state)).
type(turn_cup_over,(state,state)).
type(move_right,(state,state)).

direction(waiter,(in,out)).
direction(head,(in,out)).
direction(wants_tea,(in,)).
direction(wants_coffee,(in,)).
direction(at_end,(in,)).
direction(pour_tea,(in,out)).
direction(pour_coffee,(in,out)).
direction(turn_cup_over,(in,out)).
direction(move_right,(in,out)).

% enable_recursion.


body_pred(ho_5,4,ho).
body_pred(ho_1,3,ho).
type(ho_1,(state, state, (state, state))).
type(ho_5,(state, state, (state, state), (position, ))).
type(ho_14,(state, (position, ))).
type(ho_24,(position, state, state, (state, state))).
type(ho_44,(state, position, (position, ), (position, position, position))).
type(ho_61,(state, state, (position, position))).
type(ho_102,(state, state, (position, ), (position, ))).
type(ho_153,(state, (position, ))).
type(ho_186,(state, (position, position))).
type(ho_234,(position, state, state, (state, state))).
type(ho_316,(state, state, (position, ), (position, ))).
type(ho_511,(state, position, (position, ), (position, position, position))).
direction(ho_1,(in, out, (in, out))).
direction(ho_5,(in, out, (in, out), (in, ))).
direction(ho_14,(in, (in, ))).
direction(ho_24,(in, in, out, (in, out))).
direction(ho_44,(in, out, (out, ), (in, in, out))).
direction(ho_61,(in, in, (in, out))).
direction(ho_102,(in, out, (in, ), (in, ))).
direction(ho_153,(in, (in, ))).
direction(ho_186,(in, (in, in))).
direction(ho_234,(in, in, out, (in, out))).
direction(ho_316,(in, out, (in, ), (in, ))).
direction(ho_511,(in, out, (in, ), (in, in, out))).


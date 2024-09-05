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
type(ho_287,(state, state, (state, position), (position, ), (position, ))).
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


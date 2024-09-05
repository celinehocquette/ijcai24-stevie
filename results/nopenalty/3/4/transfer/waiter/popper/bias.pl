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


body_pred(ho_13,3,ho).
body_pred(ho_8,5,ho).
body_pred(ho_1,3,ho).
type(ho_1,(state, state, (state, state))).
type(ho_8,(state, state, (state, state), (state, position), (position, ))).
type(ho_13,(state, (position, ), (state, state))).
type(ho_25,(state, (state, position), (position, ))).
type(ho_36,(position, state, state, (state, state), (state, state))).
type(ho_53,(state, (state, position), (position, position))).
type(ho_134,(state, state, (state, state), (position, ), (position, ))).
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


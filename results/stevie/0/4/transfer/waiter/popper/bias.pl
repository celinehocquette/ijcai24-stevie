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


body_pred(ho_1,3,ho).
body_pred(ho_251,4,ho).
type(ho_1,(state, state, (state, state))).
type(ho_6,(state, (position, ))).
type(ho_16,(position, state, state, (state, state))).
type(ho_44,(state, (position, ))).
type(ho_101,(state, position, (position, ), (position, position, position))).
type(ho_132,(state, state, (position, ), (position, ))).
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


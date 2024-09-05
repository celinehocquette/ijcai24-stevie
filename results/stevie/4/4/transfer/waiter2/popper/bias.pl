max_clauses(3).
max_vars(4).
max_body(4).
max_ho(1).


%waiter(A,B) :- until(A,B,f1,at_end).
%f1(A,B) :- wants_tea(A), turn_cup_over(A,C), pour_tea(C,D), move_right(D,B).
%f1(A,B) :- wants_coffee(A), turn_cup_over(A,C), pour_coffee(C,D), move_right(D,B).

head_pred(waiter2,2).
body_pred(head,2).
body_pred(wants_tea,1).
body_pred(wants_coffee,1).
body_pred(at_end,1).
body_pred(pour_tea,2).
body_pred(pour_coffee,2).
body_pred(turn_cup_over,2).
body_pred(move_right,2).

type(waiter2,(state, state)).
type(head,(state, position)).
type(tail,(state, state)).
type(wants_tea,(state,)).
type(wants_coffee,(state,)).
type(at_end,(position,)).
type(pour_tea,(state,state)).
type(pour_coffee,(state,state)).
type(turn_cup_over,(state,state)).
type(move_right,(state,state)).

direction(waiter2,(in,out)).
direction(head,(in,out)).
direction(tail,(in,out)).
direction(wants_tea,(in,)).
direction(wants_coffee,(in,)).
direction(at_end,(in,)).
direction(pour_tea,(in,out)).
direction(pour_coffee,(in,out)).
direction(turn_cup_over,(in,out)).
direction(move_right,(in,out)).

% enable_recursion.


body_pred(ho_1,3,ho).
body_pred(ho_6,4,ho).
type(ho_1,(state, state, (state, state))).
type(ho_6,(state, state, (state, state), (position, ))).
type(ho_9,(state, (position, position))).
type(ho_109,(state, position, (position, ), (position, position, position))).
type(ho_137,(state, state, (position, ), (position, ))).
type(ho_251,(state, state, (position, position))).
type(ho_270,(state, state, (position, ), (position, ))).
type(ho_290,(state, (position, ))).
type(ho_319,(state, (position, ))).
type(ho_378,(state, position, (position, ), (position, position, position))).
type(ho_500,(position, state, state, (state, state))).
type(ho_734,(state, (position, position))).
direction(ho_1,(in, out, (in, out))).
direction(ho_6,(in, out, (in, out), (in, ))).
direction(ho_9,(in, (in, in))).
direction(ho_109,(in, out, (out, ), (in, in, out))).
direction(ho_137,(in, out, (in, ), (in, ))).
direction(ho_251,(in, in, (in, out))).
direction(ho_270,(in, out, (in, ), (in, ))).
direction(ho_290,(in, (in, ))).
direction(ho_319,(in, (in, ))).
direction(ho_378,(in, out, (in, ), (in, in, out))).
direction(ho_500,(in, in, out, (in, out))).
direction(ho_734,(in, (in, in))).


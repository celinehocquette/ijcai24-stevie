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

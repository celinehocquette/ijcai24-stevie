
%% ##################################################
%% THIS FILE CONTAINS THE ASP PROGRAM GENERATOR, CALLED ALAN
%% ##################################################

#defined direction/2.
#defined type/2.
#defined invented/2.
#defined lower/2.
#defined body_pred/3.
#defined body_pred/4.

#defined enable_pi/0.
#defined enable_recursion/0.
#defined non_datalog/0.
#defined allow_singletons/0.
#defined enable_negation/0.

#show head_literal/4.
#show body_literal/4.
#show direction_/3.
#show before/2.
#show type/2.
#show body_pred_lgrounding/5.

#heuristic size(N). [1000-N,true]

max_size(K):-
    max_body(M),
    max_clauses(N),
    K = (M+1)*N.

size(N):-
    max_size(MaxSize),
    N = 2..MaxSize,
    #sum{K+1,C : body_size(C,K)} == N.

pi_or_rec:-
    recursive.
pi_or_rec:-
    pi.
pi_or_rec:-
    invented_ho_used(_,_).
pi_or_rec_enabled:-
    enable_pi.
pi_or_rec_enabled:-
    enable_recursion.
pi_or_rec_enabled:-
    ho.

pi_or_rec_or_ho :- pi_or_rec.
pi_or_rec_or_ho :- invented_ho_used(_,_).
:-
    clause(1),
    not pi_or_rec_or_ho.

:-
    enable_recursion,
    not pi_or_ho,
    clause(Rule),
    Rule > 0,
    not recursive_clause(Rule,_,_).

pi_or_ho :- enable_pi.
pi_or_ho :- ho.


%% head pred symbol if given by user or invented
head_aux(P,A):-
    head_pred(P,A).
head_aux(P,A):-
    invented(P,A).
head_aux(P,A):-
    invented_ho_used(P,A).

%% body pred symbol if given by user or invented
body_aux(P,A):-
    body_pred(P,A).
body_aux(P,A):-
    invented(P,A).
body_aux(P,A):-
    invented_ho(P,A).
body_aux(P,A):-
    head_aux(P,A),
    enable_recursion.

%% simple negation for primitive predicates
%% a body predicate can be the negation of a primitive predicate
%% the negation of a body predicate inherit the type and direction of the non-negated predicate
type(@negative_name(P),T) :- enable_negation, body_pred(P,_), type(P,T).
direction_(@negative_name(P),A,D) :- enable_negation, body_pred(P,_), direction_(P,A,D).


#script (python)
from clingo.symbol import Function
def negative_name(name):
    return Function(f'not_{name}')
#end.

make_name(P,P,A) :- body_aux(P,A).
%% only allow negation for monadic predicates, does not make sense for dyadic
make_name(P,@negative_name(P),1) :- enable_negation, body_pred(P,1).

%% ********** BASE CASE (RULE 0) **********
head_literal(0,P,A,Vars):-
    head_pred(P,A),
    head_vars(A,Vars).

1 {body_literal(0,P1,A,Vars): body_aux(P,A), make_name(P,P1,A), vars(A,Vars)} M :-
    max_body(M).

%% ********** RECURSIVE CASE (RULE > 0) **********
%% THE SYMBOL INV_K CANNOT APPEAR IN THE HEAD OF CLAUSE C < K
0 {head_literal(Rule,P,A,Vars): head_vars(A,Vars), rule_head(P,A,Rule)} 1:-
    Rule = 1..N-1,
    max_clauses(N),
    pi_or_rec_enabled.

rule_head(P,A,Rule) :- max_clauses(N), Rule = 1..N-1, head_aux(P,A), index(P,I), Rule >= I.
rule_head(P,A,Rule) :- invented_ho_used(P,A), max_clauses(N), Rule = 1..N-1.


1 {body_literal(Rule,P1,A,Vars): body_aux(P,A), make_name(P,P1,A), vars(A,Vars)} M :-
    clause(Rule),
    Rule > 0,
    max_body(M),
    enable_recursion.

%% ********** INVENTED RULES **********
1 {body_literal(Rule,P1,A,Vars): body_aux(P,A), make_name(P,P1,A), vars(A,Vars)} M :-
    clause(Rule),
    Rule > 0,
    max_body(M),
    pi_or_ho.

%% :-
    %% invented(P,_).

bad_body(P,A,Vars):-
    invented_ho_used(P,A),
    vars(A,Vars).
bad_body(P,A,Vars):-
    head_pred(P,A),
    vars(A,Vars),
    not good_vars(A,Vars).
good_vars(A,Vars1):-
    head_vars(A,Vars2),
    var_member(V,Vars1),
    not var_member(V,Vars2).
bad_body(P,A,Vars2):-
    num_in_args(P,1),
    head_pred(P,A),
    head_vars(A,Vars1),
    vars(A,Vars2),
    var_pos(Var,Vars1,Pos1),
    var_pos(Var,Vars2,Pos2),
    direction_(P,Pos1,in),
    direction_(P,Pos2,in).

type_mismatch(C,P,Vars):-
    var_pos(Var,Vars,Pos),
    type(P,Types),
    pred_arg_type(P,Pos,T1),
    fixed_var_type(C,Var,T2),
    T1 != T2.

calls_invented(Rule):-
    invented(P,A),
    body_literal(Rule,P,A,_).
calls_invented(Rule):-
    body_literal(Rule,P,_,_),
    body_pred_lgrounding(_,_,P,_,_).
:-
    pi,
    not recursive,
    head_literal(Rule,P,A,_),
    head_pred(P,A),
    not calls_invented(Rule).


%% THERE IS A CLAUSE IF THERE IS A HEAD LITERAL
clause(C):-
    head_literal(C,_,_,_).

%% NUM BODY LITERALS OF A CLAUSE
%% TODO: IMPROVE AS EXPENSIVE
%% grounding is > c * (n choose k), where n = |Herbrand base| and k = MaxN
body_size(C,N):-
    clause(C),
    max_body(MaxN),
    N > 0,
    N <= MaxN,
    #count{P,Vars : body_literal(C,P,_,Vars)} == N.

%% USE CLAUSES IN ORDER
:-
    clause(C1),
    C1 > 1,
    C2 = 0..C1-1,
    not clause(C2).

%% USE VARS IN ORDER IN A CLAUSE
:-
    clause_var(C,Var1),
    Var1 > 1,
    Var2 = Var1-1,
    not clause_var(C,Var2).

%% ##################################################
%% VARS ABOUT VARS - META4LIFE
%% ##################################################
#script (python)
from itertools import permutations
from clingo.symbol import Tuple_, Number
def mk_tuple(xs):
    return Tuple_([Number(x) for x in xs])
def pyhead_vars(arity):
    return mk_tuple(range(arity.number))
def pyvars(arity, max_vars):
    for x in permutations(range(max_vars.number),arity.number):
        yield mk_tuple(x)
def pyvar_pos(pos, vars):
    return vars.arguments[pos.number]
#end.

%% POSSIBLE VAR
var(0..N-1):-
    max_vars(N).

%% CLAUSE VAR
clause_var(C,Var):-
    head_var(C,Var).
clause_var(C,Var):-
    body_var(C,Var).

%% HEAD VAR
head_var(C,Var):-
    head_literal(C,_,_,Vars),
    var_member(Var,Vars).
%% BODY VAR
body_var(C,Var):-
    body_literal(C,_,_,Vars),
    var_member(Var,Vars).

%% VAR IN A TUPLE OF VARS
var_member(Var,Vars):-
    var_pos(Var,Vars,_).

%% VAR IN A LITERAL
var_in_literal(C,P,Vars,Var):-
    head_literal(C,P,_,Vars),
    var_member(Var,Vars).
var_in_literal(C,P,Vars,Var):-
    body_literal(C,P,_,Vars),
    var_member(Var,Vars).

%% HEAD VARS ARE ALWAYS 0,1,...,A-1
head_vars(A,@pyhead_vars(A)):-
    head_pred(_,A).
head_vars(A,@pyhead_vars(A)):-
    invented(_,A).
head_vars(A,@pyhead_vars(A)):-
    invented_ho_used(_,A).

%% NEED TO KNOW LITERAL ARITIES
seen_arity(A):-
    head_pred(_,A).
seen_arity(A) :-
    invented_ho(_,A).
seen_arity(A):-
    body_pred(_,A).
max_arity(K):-
    #max{A : seen_arity(A)} == K.

%% POSSIBLE VARIABLE PERMUTATIONS FROM 1..MAX_ARITY
vars(A,@pyvars(A,MaxVars)):-
    max_vars(MaxVars),
    max_arity(K),
    A=1..K.

%% POSITION OF VAR IN TUPLE
var_pos(@pyvar_pos(Pos,Vars),Vars,Pos):-
    vars(A,Vars),
    Pos = 0..A-1.

%% %% ##################################################
%% %% REDUCE CONSTRAINT GROUNDING BY ORDERING CLAUSES
%% %% ##################################################
before(C1,C2):-
    C1 < C2,
    head_literal(C1,P,_,_),
    head_literal(C2,Q,_,_),
    lower(P,Q).

before(C1,C2):-
    C1 < C2,
    head_literal(C1,P,_,_),
    head_literal(C2,P,_,_),
    not recursive_clause(C1,P,A),
    recursive_clause(C2,P,A).

before(C1,C2):-
    C1 < C2,
    head_literal(C1,P,A,_),
    head_literal(C2,P,A,_),
    not recursive_clause(C1,P,A),
    not recursive_clause(C2,P,A),
    body_size(C1,K1),
    body_size(C2,K2),
    K1 < K2.

before(C1,C2):-
    C1 < C2,
    head_literal(C1,P,_,_),
    head_literal(C2,P,_,_),
    recursive_clause(C1,P,A),
    recursive_clause(C2,P,A),
    body_size(C1,K1),
    body_size(C2,K2),
    K1 < K2.

%% ##################################################
%% BIAS CONSTRAINTS
%% ##################################################
%% DATALOG
:-
    not non_datalog,
    head_var(C,Var),
    not body_var(C,Var).

%% ELIMINATE SINGLETONS
:-
    not allow_singletons,
    clause_var(C,Var),
    #count{P,Vars : var_in_literal(C,P,Vars,Var)} == 1.

%% MUST BE CONNECTED
head_connected(C,Var):-
    head_var(C,Var).
head_connected(C,Var1):-
    head_literal(C,_,A,_),
    Var1 >= A,
    head_connected(C,Var2),
    body_literal(C,_,_,Vars),
    var_member(Var1,Vars),
    var_member(Var2,Vars),
    Var1 != Var2.
:-
    head_literal(C,_,A,_),
    Var >= A,
    body_var(C,Var),
    not head_connected(C,Var).


%% ##################################################
%% SUBSUMPTION
%% ##################################################
same_head(C1,C2):-
    C1 > 0,
    C1 < C2,
    head_literal(C1,P,A,Vars),
    head_literal(C2,P,A,Vars).

not_body_subset(C1,C2):-
    C1 > 0,
    clause(C2),
    C1 < C2,
    body_literal(C1,P,A,Vars),
    not body_literal(C2,P,A,Vars).

body_subset(C1,C2):-
    C1 > 0,
    clause(C2),
    C1 < C2,
    not not_body_subset(C1,C2),
    body_literal(C1,P,A,Vars),
    body_literal(C2,P,A,Vars).
:-
    C1 > 0,
    C1 < C2,
    same_head(C1,C2),
    body_subset(C1,C2).

%% ##################################################
%% SIMPLE TYPE MATCHING
%% ##################################################
#script (python)
def pytype(pos, types):
    return types.arguments[pos.number]

def py_typelength(types):
    return Number(len(types.arguments))
#end.

fixed_var_type(C,Var,@pytype(Pos,Types)):-
    head_literal(C,P,A,Vars),
    var_pos(Var,Vars,Pos),
    type(P,Types),
    typelength(Types, A),
    head_vars(A,Vars).

typelength(Types, @py_typelength(Types)) :- type(_,Types).

pred_arg_type(P,Pos,@pytype(Pos,Types)):-
    Pos = 0..A-1,
    body_pred(P,A),
    type(P,Types).

var_type(C,Var,@pytype(Pos,Types)):-
    var_in_literal(C,P,Vars,Var),
    var_pos(Var,Vars,Pos),
    vars(A,Vars),
    type(P,Types),
    typelength(Types, A).
:-
    clause_var(C,Var),
    #count{Type : var_type(C,Var,Type)} > 1.

%% ##################################################
%% CLAUSE ORDERING
%% ##################################################
bigger(C1,C2):-
    body_size(C1,N1),
    body_size(C2,N2),
    C1 < C2,
    N1 > N2.

%% TWO NON-RECURSIVE CLAUSES
:-
    C1 < C2,
    not recursive_clause(C1,_,_),
    not recursive_clause(C2,_,_),
    same_head(C1,C2),
    bigger(C1,C2).

%% TWO NON-RECURSIVE CLAUSES
:-
    C1 > 0,
    C1 < C2,
    recursive_clause(C1,_,_),
    recursive_clause(C2,_,_),
    same_head(C1,C2),
    bigger(C1,C2).

%% ########################################
%% RECURSION
%% ########################################
num_recursive(P,N):-
    head_literal(_,P,_,_),
    #count{C : recursive_clause(C,P,_)} == N.

recursive:-
    recursive_clause(_,_,_).

recursive_clause(C,P,A):-
    head_literal(C,P,A,_),
    body_literal(C,P,A,_).

base_clause(C,P,A):-
    head_literal(C,P,A,_),
    not body_literal(C,P,A,_).

%% NO RECURSION IN THE FIRST CLAUSE
:-
    recursive_clause(0,_,_).

%% A RECURSIVE CLAUSE MUST HAVE MORE THAN ONE BODY LITERAL
:-
    C > 0,
    recursive_clause(C,_,_),
    body_size(C,1).

%% STOP RECURSION BEFORE BASE CASES
:-
    C1 > 0,
    C1 < C2,
    recursive_clause(C1,_,_),
    base_clause(C2,_,_),
    same_head(C1,C2).

%% CANNOT HAVE RECURSION WITHOUT A BASECASE
:-
    recursive_clause(_,P,A),
    not base_clause(_,P,A).

%% DISALLOW TWO RECURSIVE CALLS
%% WHY DID WE ADD THIS??
:-
    C > 0,
    recursive_clause(C,P,A),
    #count{Vars : body_literal(C,P,A,Vars)} > 1.

%% PREVENT LEFT RECURSION
%% TODO: GENERALISE FOR ARITY > 3
:-
    C > 0,
    num_in_args(P,1),
    head_literal(C,P,A,Vars1),
    body_literal(C,P,A,Vars2),
    var_pos(Var,Vars1,Pos1),
    var_pos(Var,Vars2,Pos2),
    direction_(P,Pos1,in),
    direction_(P,Pos2,in).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ENSURES INPUT VARS ARE GROUND
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#script (python)
def pydirection(pos, directions):
    return directions.arguments[pos.number]
def pylen(directions):
    return Number(len(directions.arguments))
#end.

arity(P,A):-
    head_aux(P,A).
arity(P,A):-
    body_aux(P,A).

direction_aux(P, @pylen(Directions), Directions):-
    direction(P,Directions).

direction_(P,Pos,@pydirection(Pos,Directions)):-
    arity(P,A),
    Pos=0..A-1,
    direction_aux(P,A,Directions).

num_in_args(P,N):-
    direction_(P,_,_),
    #count{Pos : direction_(P,Pos,in)} == N.

%% new!!!!!
%% VAR SAFE IF HEAD INPUT VAR
safe_bvar(Rule,Var):-
    head_literal(Rule,P,_,Vars),
    var_pos(Var,Vars,Pos),
    direction_(P,Pos,in).

safe_bvar(Rule,Var):-
    body_literal(Rule,P,_,Vars),
    num_in_args(P,0),
    var_member(Var,Vars).

safe_bvar(Rule,Var):-
    body_literal(Rule,P,_,Vars),
    var_member(Var,Vars),
    num_in_args(P,N),
    #count{Pos : var_pos(Var2,Vars,Pos), direction_(P,Pos,in), safe_bvar(Rule,Var2)} == N.

:-
    direction_(_,_,_),
    body_var(Rule,Var),
    not safe_bvar(Rule,Var).

%% ########################################
%% CLAUSES SPECIFIC TO PREDICATE INVENTION
%% ########################################

#script (python)
from itertools import permutations
from clingo.symbol import Tuple_, Number, Function
def mk_tuple(xs):
    return Tuple_([Number(x) for x in xs])
def py_gen_invsym(i):
    return Function(f'inv{i}')
#end.

pi:-
    invented(_,_).

%% P IS DEFINED BY AT LEAST TWO CLAUSES
num_clauses(P,N):-
    head_literal(_,P,_,_),
    #count{C : head_literal(C,P,_,_)} == N.

multiclause(P,A):-
    head_literal(_,P,A,_),
    not num_clauses(P,1).

%% INDEX FOR INVENTED SYMBOLS
index(P,0):-
    head_pred(P,_).
index(@py_gen_invsym(I),I):-
    I=1..N-1,
    max_clauses(N).

inv_symbol(P):-
    index(P,I),
    I>0.

{invented(P,A)}:-
    enable_pi,
    inv_symbol(P),
    max_arity(MaxA),
    A = 1..MaxA.

%% CANNOT INVENT A PREDICATE WITH MULTIPLE ARITIES
:-
    invented(P,_),
    #count{A : invented(P,A)} != 1.

inv_lower(P,Q):-
    pi,
    inv_symbol(P),
    inv_symbol(Q),
    I < J,
    index(P,I),
    index(Q,J).
lower(P,Q):-
    head_pred(P,_),
    invented(Q,_).
lower(P,Q):-
    inv_lower(P,Q).
lower(P,Q):-
    lower(P,R),
    lower(R,Q).

%% NO RECURSIVE INVENTED CLAUSE UNLESS RECURSION IS ENABLED
:-
    not enable_recursion,
    invented(P,A),
    recursive_clause(_,P,A).

%% MUST LEARN PROGRAMS WITH ORDERED CLAUSES
:-
    C1 < C2,
    head_literal(C1,P,_,_),
    head_literal(C2,Q,_,_),
    lower(Q,P).

%% AN INVENTED SYMBOL MUST APPEAR IN THE HEAD OF A CLAUSE
:-
    invented(P,A),
    not head_literal(_,P,A,_).

%% AN INVENTED SYMBOL MUST APPEAR IN THE BODY OF A CLAUSE DEFINED BEFORE THE INVENTED ONE
appears_before(P,A):-
    invented(P,A),
    lower(Q,P),
    head_literal(C,Q,_,_),
    body_literal(C,P,_,_).

%% AN INVENTED SYMBOL MUST APPEAR IN THE BODY OF A CLAUSE
:-
    invented(P,A),
    not appears_before(P,A).

%% MUST INVENT IN ORDER
:-
    invented(P,_),
    inv_lower(Q,P),
    not invented(Q,_).

%% FORCE ORDERING
%% inv2(A):- inv1(A)
:-
    head_literal(C,P,_,_),
    body_literal(C,Q,_,_),
    lower(Q,P).

%% USE INVENTED SYMBOLS IN ORDER
%% f(A):- inv2(A)
%% inv2(A):- q(A)
%% TODO: ENFORCE ONLY ON ONE DIRECTLY BELOW
%% :-
    %% invented(P,_),
    %% head_literal(_,P,_,_),
    %% inv_lower(Q,P),
    %% not head_literal(_,Q,_,_).

%% PREVENT DUPLICATE INVENTED CLAUSES
%% f(A,B):-inv1(A,C),inv2(C,B).
:-
    C1 > 0,
    C2 > 0,
    C1 < C2,
    lower(P,Q),
    head_literal(C1,P,_,_),
    head_literal(C2,Q,_,_),
    invented(P,_),
    invented(Q,_),
    body_subset(C1,C2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% TYPES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% INHERIT TYPE FROM CALLING PREDICATE
%% p(A,B):-inv1(A,B). (C2)
%% inv1(X,Y):-q(X,Y). (C1)
%% X and Y should inherit the types of A and B respectively
var_type(C1,Var1,Type):-
    invented(P,A),
    C1 > C2,
    head_literal(C1,P,A,Vars1),
    body_literal(C2,P,A,Vars2),
    var_pos(Var1,Vars1,Pos),
    var_pos(Var2,Vars2,Pos),
    var_type(C2,Var2,Type).

%% INHERIT TYPE FROM CALLED PREDICATE
%% p(A,B):-inv1(A,B). (C2)
%% inv1(X,Y):-q(X,Y). (C1)
%% A and B should inherit the types of X and Y respectively
var_type(C2,Var2,Type):-
    invented(P,A),
    C1 > C2,
    head_literal(C1,P,A,Vars1),
    body_literal(C2,P,A,Vars2),
    var_pos(Var1,Vars1,Pos),
    var_pos(Var2,Vars2,Pos),
    var_type(C1,Var1,Type).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DIRECTIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PRUNES SINGLE CLAUSE/LITERAL INVENTIONS
%% inv(A,B):-right(A,B).
:-
    invented(P,A),
    not invented_ho(P,A),
    head_literal(C,P,A,_),
    body_size(C,1),
    not multiclause(P,A).

%% ALLOW SINGLE CLAUSE/LITERAL IF THE ORDER OF VARIABLES IS DIFFERENT OR IF IT IS ANOTHER HO PREDICATE
:-
    invented_ho_used(P,A),
    head_literal(C,P,A,Vars),
    body_size(C,1),
    body_literal(C,P1,_,Vars),
    not body_pred_lgrounding(_,_,P1,_,_),
    not multiclause(P,A).


%% PREVENTS SINGLE CLAUSE/LITERAL CALLS
%% f(A,B):-inv(A,B)
:-
    head_literal(C,P,Pa,_),
    invented(Q,Qa),
    body_literal(C,Q,Qa,_),
    body_size(C,1),
    not multiclause(P,Pa).

only_once(P,A):-
    invented(P,A),
    head_literal(_,P,A,_),
    #count{C,Vars : body_literal(C,P,A,Vars)} == 1.

:-
    invented(P,_),
    #count{A : invented(P,A)} != 1.

:-
    invented(P,A),
    head_literal(C1,P,A,_),
    not multiclause(P,A),
    only_once(P,A),
    C2 < C1,
    body_literal(C2,P,A,_),
    body_size(C1,N1),
    body_size(C2,N2),
    max_body(MaxN),
    N1 + N2 - 1 <= MaxN.

%%% depends on relation - necessary for redundancy constraints and higher-order programs
% NB: following assumes that the body literal can always be unified with the head literal - an assumption that holds for now...
depends_on(C1,C2) :-
    C1 != C2,
    head_literal(C2,Pred,Arity,_),
    body_literal(C1,Pred,Arity,_).
depends_on(C1,C3) :-
    C1 != C3,
    depends_on(C1,C2),
    depends_on(C2,C3).

ho :-
    body_literal(_,P,_,_),
    body_pred_lgrounding(_,_,P,_,_).

invented_ho(P,@pypred_pos_((A,),0)) :-
    body_pred_lgrounding(Pred,(P,),_,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A,)).

invented_ho(P,@pypred_pos_((A1,A2),0)) :-
    body_pred_lgrounding(Pred,(P,_),_,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2)).

invented_ho(P,@pypred_pos_((A1,A2),1)) :-
    body_pred_lgrounding(Pred,(_,P),_,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2)).

invented_ho(P,@pypred_pos_((A1,A2,A3),0)) :-
    body_pred_lgrounding(Pred,(P,_,_),_,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)).
invented_ho(P,@pypred_pos_((A1,A2,A3),1)) :-
    body_pred_lgrounding(Pred,(_,P,_),_,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)).
invented_ho(P,@pypred_pos_((A1,A2,A3),2)) :-
    body_pred_lgrounding(Pred,(_,_,P),_,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)).

ho_idx(P,@name_to_idx(P)) :- invented_ho_used(P,_).

%% USE HO PREDS IN ORDER
:- ho_idx(P,I1), I1>=0,  I2 = 0..I1-1, not ho_idx(_,I2).

%% AN INVENTED SYMBOL RELATED TO A SELECTED HO PRED MUST APPEAR IN THE HEAD OF A CLAUSE
:-
    invented_ho_used(P,A),
    not head_literal(_,P,A,_).

%% AN HO INVENTED SYMBOL CANNOT APPEAR AS HEAD OR BODY PRED IF IT IS NOT SELECTED
:-
    invented_ho(P,A),
    not head_pred(P,A),
    head_literal(_,P,A,_),
    not invented_ho_used(P,A).

:-
    invented_ho(P,A),
    body_literal(_,P,A,_),
     not body_pred(P,A),
    not invented_ho_used(P,A).

%% Weight each pre_body_literal by its second argument when evaluating the sum.
%% The second argument can be at most the maximum number of allowed higher-order
%% instances.
%0 <= #sum{X:pre_body_literal(P,X):X=1..HO,body_pred_lgrounding(_,_,P,_,_)}<=HO :-
%    max_ho(HO).
%% The second argument of pre_body_literal indicates how many instances of P can
%% occur in a hypothesis. The count checks if the number of body_literals associated
%% with P is precisely the number of instances indicated by pre_body_literal
%:-
%    pre_body_literal(P,X),
 %   #count{C,V:body_literal(C,P,_,V)}!=X.


0{pre_body_literal(P,1..HO):body_pred_lgrounding(_,_,P,_,_)}HO :- max_ho(HO).

:- body_literal(_,P,_,_),
   body_pred_lgrounding(_,_,P,_,_),
   not pre_body_literal(P,_).

:- pre_body_literal(P,_),
   #count{V:body_literal(_,P,_,V)}=X,
   #count{Z:pre_body_literal(P,Z)}=Y,
   X!=Y.

invented_ho_used(P,A) :-
    body_pred_lgrounding(Pred,(P,),P1,_,_),
    body_literal(_,P1,A1,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A,)),
    not body_pred(P,A),
    not head_pred(P,A).

invented_ho_used(P,A) :-
    body_pred_lgrounding(Pred,(P,_),P1,_,_),
    body_literal(_,P1,A1,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A,_)),
    not body_pred(P,A),
    not head_pred(P,A).
invented_ho_used(P,A) :-
    body_pred_lgrounding(Pred,(_,P),P1,_,_),
    body_literal(_,P1,A1,_),
    type(Pred,Types),
    fo_preds_arity(Types,(_,A)),
    body_literal(_,P1,_,_),
    not body_pred(P,A),
    not head_pred(P,A).

invented_ho_used(P,A) :-
    body_pred_lgrounding(Pred,(P,_,_),P1,_,_),
    body_literal(_,P1,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(A,_,_)),
    not body_pred(P,A),
    not head_pred(P,A).
invented_ho_used(P,A) :-
    body_pred_lgrounding(Pred,(_,P,_),P1,_,_),
    body_literal(_,P1,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(_,A,_)),
    not body_pred(P,A),
    not head_pred(P,A).
invented_ho_used(P,A) :-
    body_pred_lgrounding(Pred,(_,_,P),P1,_,_),
    body_literal(_,P1,_,_),
    type(Pred,Types),
    fo_preds_arity(Types,(_,_,A)),
    not body_pred(P,A),
    not head_pred(P,A).


%pred_pos(@pypred_pos(Ps),Ps) :- body_pred_lgrounding(_,Ps,_,_,_).

%% HELPERS FOR HIGHER-ORDER ARGUMENTS
#script (python)
from clingo.symbol import Tuple_, Number, Function, SymbolType, String
TRUE = Function(name="true")
FALSE = Function(name="false")
# TODO: higher-order does not work without types
def lgroundname(pred, types, preds):
    arg_to_name = {}
    preds = iter(preds.arguments)
    for idx, t in enumerate(types.arguments):
        if t.arguments != []:
            arg_to_name[idx] = next(preds).name
    suffix = '___'.join(f"{idx}{name}" for (idx, name) in arg_to_name.items())
    return Function(name=pred.name + '___' + suffix)

def lgroundtypes(types, fo_or_ho):
    fotypes = tuple(type for type in types.arguments if type.arguments == [])
    hotypes = tuple(type for type in types.arguments if type.arguments != [])
    if len(hotypes) == 0:
        return []
    return Tuple_(fotypes) if fo_or_ho.name == 'fo' else Tuple_(hotypes)
lgrounddirs = lgroundtypes # this impl. is exactly the same (upto alpha-renaming)
def lgroundarity(types, fo_or_ho):
    fotypes = tuple(type for type in types.arguments if type.arguments == [])
    hotypes = tuple(type for type in types.arguments if type.arguments != [])
    if len(hotypes) == 0:
        return []
    return Number(len(fotypes)) if fo_or_ho.name == 'fo' else Number(len(hotypes))

def numargs(tuple_):
    return Number(len(tuple_.arguments))

def index(elt, tuple):
    for idx, arg in enumerate(tuple.arguments):
        if arg == elt:
            yield Number(idx)

def atindex(tuple, idx):
    if idx.number < len(tuple.arguments):
      return tuple.arguments[idx.number]
    else:
      return Tuple_([])

def pypred_pos(ps):
    for p in ps.arguments:
        yield p

def pypred_pos_(ps, pos):
    return ps.arguments[pos.number]

def lenatindex(tuple,idx):
    return Number(len(tuple.arguments[idx.number]))

def inv_preds(idx):
    return Number(len(tuple.arguments[idx.number]))

def pypreds_fo_arity(types):
    hotypes = tuple(type for type in types.arguments if type.arguments != [])
    ho_arity_types = tuple(Number(len(type.arguments)) for type in hotypes)
    return Tuple_(ho_arity_types)

# at most one invented predicate per clause
def make_invho_name(pred, i, max_clauses, max_ho):
    for c in range(min([max_clauses.number, max_ho.number])):
        yield Function(name=f"inv_ho_{c}")

def name_to_idx(P):
    return Number(int(P.name.split("_")[-1]))

def match_dirs(hd,d):
    if len(hd.arguments)==len(d.arguments):
        for i in range(0,len(hd.arguments)):
            if hd.arguments[i] != d.arguments[i]:
                return TRUE if d.arguments[i].name== "out" else FALSE
        return TRUE
    return FALSE
#end.

body_pred(Pred,@lgroundarity(Types,fo),@lgroundarity(Types,ho),ho) :-
    body_pred(Pred,_Arity,ho),
    type(Pred,Types).
seen_arity(A):-
    body_pred(_,A,_,ho).

body_pred_(P,A) :- body_pred(P,A).
body_pred_(P,A) :- enable_recursion, head_pred(P,A).

%% DERIVE THE L-GROUNDINGS OF HIGHER-ORDER PREDICATES
%% TODO: need the directions to match exactly, whereas out could be used instead of in
body_pred_lgrounding(Pred,(P,),@lgroundname(Pred,Types,(P,)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,1,ho),
    type(Pred,Types),
    body_pred_(P,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P,@atindex(@lgroundtypes(Types,ho),0)),
    direction(Pred,HoDirs),
    direction(P,ArgDirs),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs) = true.

body_pred_lgrounding(Pred,(P,),@lgroundname(Pred,Types,(P,)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,1,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A,)),
    max_clauses(M),
    max_ho(N),
    P = @make_invho_name(Pred,1,M,N).

body_pred_lgrounding(Pred,(P1,P2),@lgroundname(Pred,Types,(P1,P2)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,2,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2)),
    direction(Pred,HoDirs),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true.

body_pred_lgrounding(Pred,(P1,P2),@lgroundname(Pred,Types,(P1,P2)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,2,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2)),
    direction(Pred,HoDirs),
    max_clauses(M),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    max_ho(N),
    P2 = @make_invho_name(Pred,2,M,N).

body_pred_lgrounding(Pred,(P1,P2),@lgroundname(Pred,Types,(P1,P2)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,2,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2)),
    max_clauses(M),
    direction(Pred,HoDirs),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true.

body_pred_lgrounding(Pred,(P1,P2),@lgroundname(Pred,Types,(P1,P2)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,2,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2)),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    P2 = @make_invho_name(Pred,2,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3),@lgroundname(Pred,Types,(P1,P2,P3)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,3,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)),
    direction(Pred,HoDirs),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true.

body_pred_lgrounding(Pred,(P1,P2,P3),@lgroundname(Pred,Types,(P1,P2,P3)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,3,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true.

body_pred_lgrounding(Pred,(P1,P2,P3),@lgroundname(Pred,Types,(P1,P2,P3)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,3,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    P2 = @make_invho_name(Pred,2,M,N),
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true.

body_pred_lgrounding(Pred,(P1,P2,P3),@lgroundname(Pred,Types,(P1,P2,P3)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,3,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)),
    direction(Pred,HoDirs),
    max_clauses(M),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    max_ho(N),
    P2 = @make_invho_name(Pred,2,M,N),
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true.

body_pred_lgrounding(Pred,(P1,P2,P3),@lgroundname(Pred,Types,(P1,P2,P3)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,3,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)),
    direction(Pred,HoDirs),
    max_clauses(M),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    max_ho(N),
    P3 = @make_invho_name(Pred,3,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3),@lgroundname(Pred,Types,(P1,P2,P3)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,3,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    P3 = @make_invho_name(Pred,3,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3),@lgroundname(Pred,Types,(P1,P2,P3)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,3,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    P2 = @make_invho_name(Pred,2,M,N),
    P3 = @make_invho_name(Pred,3,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3),@lgroundname(Pred,Types,(P1,P2,P3)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,3,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3)),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    P2 = @make_invho_name(Pred,2,M,N),
    P3 = @make_invho_name(Pred,3,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    P2 = @make_invho_name(Pred,2,M,N),
    P3 = @make_invho_name(Pred,3,M,N),
    P4 = @make_invho_name(Pred,4,M,N).
body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    P2 = @make_invho_name(Pred,2,M,N),
    P3 = @make_invho_name(Pred,3,M,N),
    P4 = @make_invho_name(Pred,4,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    P3 = @make_invho_name(Pred,3,M,N),
    P4 = @make_invho_name(Pred,4,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    P2 = @make_invho_name(Pred,2,M,N),
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true,
    P4 = @make_invho_name(Pred,4,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    P2 = @make_invho_name(Pred,2,M,N),
    P3 = @make_invho_name(Pred,3,M,N),
    body_pred_(P4,@numargs(@atindex(@lgroundtypes(Types,ho),3))),
    type(P4,@atindex(@lgroundtypes(Types,ho),3)),
    direction(P4,ArgDirs4),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),3),ArgDirs4) = true.

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    P3 = @make_invho_name(Pred,3,M,N),
    P4 = @make_invho_name(Pred,4,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    P2 = @make_invho_name(Pred,2,M,N),
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true,
    P4 = @make_invho_name(Pred,4,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    P2 = @make_invho_name(Pred,2,M,N),
    P3 = @make_invho_name(Pred,3,M,N),
    body_pred_(P4,@numargs(@atindex(@lgroundtypes(Types,ho),3))),
    type(P4,@atindex(@lgroundtypes(Types,ho),3)),
    direction(P4,ArgDirs4),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),3),ArgDirs4) = true.

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true,
    P4 = @make_invho_name(Pred,4,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    P3 = @make_invho_name(Pred,3,M,N),
    body_pred_(P4,@numargs(@atindex(@lgroundtypes(Types,ho),3))),
    type(P4,@atindex(@lgroundtypes(Types,ho),3)),
    direction(P4,ArgDirs4),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),3),ArgDirs4) = true.

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    P2 = @make_invho_name(Pred,2,M,N),
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true,
    body_pred_(P4,@numargs(@atindex(@lgroundtypes(Types,ho),3))),
    type(P4,@atindex(@lgroundtypes(Types,ho),3)),
    direction(P4,ArgDirs4),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),3),ArgDirs4) = true.

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true,
    P4 = @make_invho_name(Pred,4,M,N).

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    P1 = @make_invho_name(Pred,1,M,N),
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true,
    body_pred_(P4,@numargs(@atindex(@lgroundtypes(Types,ho),3))),
    type(P4,@atindex(@lgroundtypes(Types,ho),3)),
    direction(P4,ArgDirs4),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),3),ArgDirs4) = true.

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    P2 = @make_invho_name(Pred,2,M,N),
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true,
    body_pred_(P4,@numargs(@atindex(@lgroundtypes(Types,ho),3))),
    type(P4,@atindex(@lgroundtypes(Types,ho),3)),
    direction(P4,ArgDirs4),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),3),ArgDirs4) = true.

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    max_ho(N),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    P3 = @make_invho_name(Pred,3,M,N),
    body_pred_(P4,@numargs(@atindex(@lgroundtypes(Types,ho),3))),
    type(P4,@atindex(@lgroundtypes(Types,ho),3)),
    direction(P4,ArgDirs4),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),3),ArgDirs4) = true.

body_pred_lgrounding(Pred,(P1,P2,P3,P4),@lgroundname(Pred,Types,(P1,P2,P3,P4)),@lgroundtypes(Types,fo),@lgroundtypes(Types,ho)) :-
    body_pred(Pred,FoArity,4,ho),
    type(Pred,Types),
    fo_preds_arity(Types,(A1,A2,A3,A4)),
    direction(Pred,HoDirs),
    max_clauses(M),
    body_pred_(P1,@numargs(@atindex(@lgroundtypes(Types,ho),0))),
    type(P1,@atindex(@lgroundtypes(Types,ho),0)),
    direction(P1,ArgDirs1),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),0),ArgDirs1) = true,
    body_pred_(P2,@numargs(@atindex(@lgroundtypes(Types,ho),1))),
    type(P2,@atindex(@lgroundtypes(Types,ho),1)),
    direction(P2,ArgDirs2),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),1),ArgDirs2) = true,
    body_pred_(P3,@numargs(@atindex(@lgroundtypes(Types,ho),2))),
    type(P3,@atindex(@lgroundtypes(Types,ho),2)),
    direction(P3,ArgDirs3),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),2),ArgDirs3) = true,
    body_pred_(P4,@numargs(@atindex(@lgroundtypes(Types,ho),3))),
    type(P4,@atindex(@lgroundtypes(Types,ho),3)),
    direction(P4,ArgDirs4),
    @match_dirs(@atindex(@lgrounddirs(HoDirs,ho),3),ArgDirs4) = true.


fo_preds_arity(Types,@pypreds_fo_arity(Types)) :- body_pred(Pred,_Arity,ho), type(Pred,Types).

%% PROJECT DOWN FULL INFO FROM L-GROUNDING TO FIRST-ORDER POPPER SETTINGS
body_aux(LgroundPredName,@numargs(FoTypes)) :-
    body_pred_lgrounding(_Pred,_Lgrounding,LgroundPredName,FoTypes,_HoTypes).
type(LgroundPredName,FoTypes) :-
    body_pred_lgrounding(_Pred,_Lgrounding,LgroundPredName,FoTypes,_HoTypes).
direction(LgroundPredName,@lgrounddirs(Dirs,fo)) :-
    body_pred_lgrounding(Pred,_LGrounding,LgroundPredName,_FoTypes,_HoTypes),
    direction(Pred,Dirs).

%% INFER TYPE AND DIRECTION FOR INVENTED PREDICATES WHICH OCCUR AS HIGHER-ORDER ARGUMENTS
type(P,@atindex(HoTypes,LgroundIdx)) :-
    body_pred_lgrounding(_HoPred,Lgrounding,LgroundPredName,_FoTypes,HoTypes),
    invented_ho(P,A),
    LgroundIdx=@index(P,Lgrounding),
    clause(C1),
    body_literal(C1,LgroundPredName,_,_),
    clause(C2),
    head_literal(C2,P,_,_).
:- type(P,T1),type(P,T2),T1 != T2.
direction(P,@atindex(@lgrounddirs(HoDirs,ho),LgroundIdx)) :-
    body_pred_lgrounding(HoPred,Lgrounding,LgroundPredName,_FoTypes,_HoTypes),
    direction(HoPred,HoDirs),
    invented_ho(P,A),
    LgroundIdx=@index(P,Lgrounding),
    body_literal(C1,LgroundPredName,_,_),
    head_literal(C2,P,_,_).
:- direction(P,Dirs),invented(P,A),A != @pylen(Dirs).
:- direction(P,D1),direction(P,D2),D1 != D2.

%% EXTEND THE CLAUSE DEPENDENCY GRAPH TO ACCOUNT FOR HIGHER-ORDER ARGUMENTS
depends_on(C1,C2) :-
    invented(P,A),
    body_pred_lgrounding(_HoPred,Lgrounding,LgroundPredName,_FoTypes,_HoTypes),
    LgroundIdx=@index(P,Lgrounding),
    body_literal(C1,LgroundPredName,_,_),
    head_literal(C2,P,_,_).


%% EXTEND THE CHECK ON ORDERING OF PREDICATES IN CLAUSES TO ACCOUNT FOR HIGHER-ORDER ARGUMENTS
appears_before(P,A):-
    invented(P,A),
    lower(Q,P),
    head_literal(C,Q,_,_),
    body_literal(C,LgroundPredName,_,_),
    body_pred_lgrounding(_HoPred,Lgrounding,LgroundPredName,_FoTypes,_HoTypes),
    Dummy=@index(P,Lgrounding).

%% %% ==========================================================================================
%% %% BK BIAS CONSTRAINTS
%% %% ==========================================================================================

#defined prop/2.
#defined prop/3.


%% :- prop(singleton,P), body_literal(Rule,P,1,_), #count{A : body_literal(Rule,P,A,(A,))} > 1.
:- prop(singleton,P), body_literal(Rule,P,_,_), #count{Vars : body_literal(Rule,P,A,Vars)} > 1.

:- prop(symmetric_ab_c,P), body_literal(_,P,_,(A,B,_)), A>B.
:- prop(symmetric_ab,P), body_literal(_,P,_,(A,B)), A>B.
:- prop(asymmetric_ab_ba,P), body_literal(Rule,P,_,(A,B)), body_literal(Rule,P,_,(B,A)).
:- prop(asymmetric_abc_acb,P), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,P,_,(A,C,B)).
:- prop(asymmetric_abc_bac,P), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,P,_,(B,A,C)).
:- prop(asymmetric_abc_bca,P), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,P,_,(B,C,A)).
:- prop(asymmetric_abc_cab,P), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,P,_,(C,A,B)).
:- prop(asymmetric_abc_cba,P), body_literal(Rule,P,_,(A,B,C)), body_literal(Rule,P,_,(C,B,A)).
:- prop(asymmetric_abcd_abdc,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(A,B,D,C)).
:- prop(asymmetric_abcd_acbd,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(A,C,B,D)).
:- prop(asymmetric_abcd_acdb,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(A,C,D,B)).
:- prop(asymmetric_abcd_adbc,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(A,D,B,C)).
:- prop(asymmetric_abcd_adcb,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(A,D,C,B)).
:- prop(asymmetric_abcd_bacd,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(B,A,C,D)).
:- prop(asymmetric_abcd_badc,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(B,A,D,C)).
:- prop(asymmetric_abcd_bcad,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(B,C,A,D)).
:- prop(asymmetric_abcd_bcda,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(B,C,D,A)).
:- prop(asymmetric_abcd_bdac,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(B,D,A,C)).
:- prop(asymmetric_abcd_bdca,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(B,D,C,A)).
:- prop(asymmetric_abcd_cabd,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(C,A,B,D)).
:- prop(asymmetric_abcd_cadb,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(C,A,D,B)).
:- prop(asymmetric_abcd_cbad,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(C,B,A,D)).
:- prop(asymmetric_abcd_cbda,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(C,B,D,A)).
:- prop(asymmetric_abcd_cdab,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(C,D,A,B)).
:- prop(asymmetric_abcd_cdba,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(C,D,B,A)).
:- prop(asymmetric_abcd_dabc,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(D,A,B,C)).
:- prop(asymmetric_abcd_dacb,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(D,A,C,B)).
:- prop(asymmetric_abcd_dbac,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(D,B,A,C)).
:- prop(asymmetric_abcd_dbca,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(D,B,C,A)).
:- prop(asymmetric_abcd_dcab,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(D,C,A,B)).
:- prop(asymmetric_abcd_dcba,P), body_literal(Rule,P,_,(A,B,C,D)), body_literal(Rule,P,_,(D,C,B,A)).

:- prop(unique_a_b,P), body_literal(Rule,P,_,(A,_)), #count{B : body_literal(Rule,P,_,(A,B))} > 1.
:- prop(unique_a_bc,P), body_literal(Rule,P,_,(A,_,_)), #count{B,C : body_literal(Rule,P,_,(A,B,C))} > 1.
:- prop(unique_a_bcd,P), body_literal(Rule,P,_,(A,_,_,_)), #count{B,C,D : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_ab_c,P), body_literal(Rule,P,_,(A,B,_)), #count{C : body_literal(Rule,P,_,(A,B,C))} > 1.
:- prop(unique_ab_cd,P), body_literal(Rule,P,_,(A,B,_,_)), #count{C,D : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_abc_d,P), body_literal(Rule,P,_,(A,B,C,_)), #count{D : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_abd_c,P), body_literal(Rule,P,_,(A,B,_,D)), #count{C : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_ac_b,P), body_literal(Rule,P,_,(A,_,C)), #count{B : body_literal(Rule,P,_,(A,B,C))} > 1.
:- prop(unique_ac_bd,P), body_literal(Rule,P,_,(A,_,C,_)), #count{B,D : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_acd_b,P), body_literal(Rule,P,_,(A,_,C,D)), #count{B : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_ad_bc,P), body_literal(Rule,P,_,(A,_,_,D)), #count{B,C : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_b_a,P), body_literal(Rule,P,_,(_,B)), #count{A : body_literal(Rule,P,_,(A,B))} > 1.
:- prop(unique_b_ac,P), body_literal(Rule,P,_,(_,B,_)), #count{A,C : body_literal(Rule,P,_,(A,B,C))} > 1.
:- prop(unique_b_acd,P), body_literal(Rule,P,_,(_,B,_,_)), #count{A,C,D : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_bc_a,P), body_literal(Rule,P,_,(_,B,C)), #count{A : body_literal(Rule,P,_,(A,B,C))} > 1.
:- prop(unique_bc_ad,P), body_literal(Rule,P,_,(_,B,C,_)), #count{A,D : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_bcd_a,P), body_literal(Rule,P,_,(_,B,C,D)), #count{A : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_bd_ac,P), body_literal(Rule,P,_,(_,B,_,D)), #count{A,C : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_c_ab,P), body_literal(Rule,P,_,(_,_,C)), #count{A,B : body_literal(Rule,P,_,(A,B,C))} > 1.
:- prop(unique_c_abd,P), body_literal(Rule,P,_,(_,_,C,_)), #count{A,B,D : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_cd_ab,P), body_literal(Rule,P,_,(_,_,C,D)), #count{A,B : body_literal(Rule,P,_,(A,B,C,D))} > 1.
:- prop(unique_d_abc,P), body_literal(Rule,P,_,(_,_,_,D)), #count{A,B,C : body_literal(Rule,P,_,(A,B,C,D))} > 1.

:- prop(antitransitive,P), body_literal(Rule,P,_,(A,B)), body_literal(Rule,P,_,(B,C)), body_literal(Rule,P,_,(A,C)).

:- prop(antitriangular,P), body_literal(Rule,P,_,(A,B)), body_literal(Rule,P,_,(B,C)), body_literal(Rule,P,_,(C,A)).

:- prop(unsat_pair,P,Q), body_literal(Rule,P,_,Vars), body_literal(Rule,Q,_,Vars).

:- prop(precon,P,Q), body_literal(Rule,P,_,(A,)), body_literal(Rule,Q,_,(A,B)).
:- prop(postcon,P,Q), body_literal(Rule,P,_,(A,B)), body_literal(Rule,Q,_,(B,)).
:- prop(pre_postcon,(P,Q,R)), body_literal(Rule,P,_,(A,)),body_literal(Rule,Q,_,(A,B)),body_literal(Rule,R,_,(B,)).
:- prop(chain,(P,Q)), body_literal(Rule,P,_,(_,A)),body_literal(Rule,Q,_,(A,_)).
:- prop(countk,P,K), K > 1, body_pred(P,_), clause(Rule), #count{Vars : body_literal(Rule,P,_,Vars)} > K.


:-
    Rule > 0,
    head_literal(Rule,P,_,(A,_)),
    body_literal(Rule,P,_,(_,A)).

:-
    Rule > 0,
    head_literal(Rule,P,_,(_,A)),
    body_literal(Rule,P,_,(A,_)).


%% PREVENT LEFT RECURSION
%% TODO: GENERALISE FOR ARITY > 3
:-
    C > 0,
    num_in_args(P,2),
    head_literal(C,P,A,Vars1),
    body_literal(C,P,A,Vars2),
    Var1 != Var2,
    var_pos(Var1,Vars1,V1Pos1),
    var_pos(Var1,Vars2,V1Pos2),
    direction_(P,V1Pos1,in),
    direction_(P,V1Pos2,in),
    var_pos(Var2,Vars1,V2Pos1),
    var_pos(Var2,Vars2,V2Pos2),
    direction_(P,V2Pos1,in),
    direction_(P,V2Pos2,in).

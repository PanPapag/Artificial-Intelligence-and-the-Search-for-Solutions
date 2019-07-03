% cannibal.pl
% This program solves the cannibals and missionaries puzzle

cannibal :-
  solve_cannibal([state(3,3,l)],Solution),
  reverse(Solution,OrderedSolution),
  show_states(OrderedSolution).

solve_cannibal([state(0,0,r)|PriorStates],[state(0,0,r)|PriorStates]).
solve_cannibal([state(M1,C1,l)|PriorStates],Solution) :-
  member([M,C],[[0,1],[1,0],[1,1],[2,0],[0,2]]),
  M =< M1, C =< C1,
  M2 is M1 - M, C2 is C1 - C,
  member([M2,C2],[[3,_],[0,_],[N,N]]),
  \+ member(state(M2,C2,r),PriorStates),
  solve_cannibal([state(M2,C2,r),state(M1,C1,l)|PriorStates],Solution).
solve_cannibal([state(M1,C1,r)|PriorStates],Solution) :-
  member([M,C],[[0,1],[1,0],[1,1],[2,0],[0,2]]),
  M =< 3 - M1, C =< 3 - C1,
  M2 is M1 + M, C2 is C1 + C,
  member([M2,C2],[[3,_],[0,_],[N,N]]),
  \+ member(state(M2,C2,l),PriorStates),
  solve_cannibal([state(M2,C2,l),state(M1,C1,r)|PriorStates],Solution).

show_states([]).
show_states([state(M,C,Location)|LaterStates]) :-
  write_n_times('M',M),
  write_n_times('C',C),
  N is 6 - M - C,
  write_n_times(' ',N),
  draw_boat(Location),
  RM is 3 - M,
  RC is 3 - C,
  write_n_times('M',RM),
  write_n_times('C',RC),
  nl,
  show_states(LaterStates).

write_n_times(_,0) :- !.
write_n_times(Item,N) :-
  write(Item),
  N1 is N - 1,
  write_n_times(Item,N1).

draw_boat(l) :- write(' (____)     ').
draw_boat(r) :- write('     (____) ').

% cannibal.pl
% This program solves the cannibals and missionaries puzzle

cannibal :-
  solve_cannibal([state(3,3,l)],Solution),
  reverse(Solution,OrderedSolution),
  show_states(OrderedSolution).

show_states([]).
show_states([state(M,C,Location)|RestStates]) :-
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
  show_states(RestStates).

draw_boat(l) :- write(' (____)     ')
draw_boat(r) :- write('     (____) ')

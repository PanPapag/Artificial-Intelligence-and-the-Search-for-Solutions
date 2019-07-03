% cannibal.pl
% This program solves the cannibals and missionaries puzzle

cannibal :-
  solve_cannibal([state(3,3,l)],Solution),
  reverse(Solution,OrderedSolution).

  

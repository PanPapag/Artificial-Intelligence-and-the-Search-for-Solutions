:- [input1_maze].

solve_maze :-
  findall(ReversedSolution, path([start], ReversedSolution), Solutions), 
  shortest_path(Solutions).

path([finish|RestOfPath],[finish|RestOfPath]).
path([CurrentLocation|RestOfPath],Solution) :-
  connected_to(CurrentLocation,NextLocation),
  \+ member(NextLocation,RestOfPath),
  path([NextLocation,CurrentLocation|RestOfPath],Solution).

connected_to(Location1,Location2) :- connect(Location1,Location2).
connected_to(Location1,Location2) :- connect(Location2,Location1).

shortest_path(Solutions) :-
  compute_lengths(Solutions, LengthOfEachSolution),
  min_list(LengthOfEachSolution, MinLength),
  get_shortest_paths(Solutions, LengthOfEachSolution, MinLength, ShortestSolutions),
  print_shortest_paths(ShortestSolutions).

compute_lengths([],[]).
compute_lengths([Solution|RestOfSolutions],[Cost|RestofLengths]) :-
  length(Solution,Cost),
  compute_lengths(RestOfSolutions,RestofLengths).

get_shortest_paths([],[],_,[]).
get_shortest_paths([Solution|RestOfSolutions],[MinLength|RestofLengths],MinLength,[Solution|RestOfShortestSolutions]) :-
  get_shortest_paths(RestOfSolutions, RestofLengths,MinLength,RestOfShortestSolutions).
get_shortest_paths([_|RestOfSolutions],[_|RestofLengths],MinLength,ShortestSolutions) :-
  get_shortest_paths(RestOfSolutions, RestofLengths, MinLength,ShortestSolutions).

print_shortest_paths([]).
print_shortest_paths([ReversedSolution|RestOfSolutions]) :-
  reverse(ReversedSolution,Solution),
  writeln(Solution),
  print_shortest_paths(RestOfSolutions).

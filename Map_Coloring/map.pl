:- [data].

map :- color_map([],Solution), writeln(Solution).

color_map(Sofar,Solution) :-
  country(Country),
  \+ member([Country,_],Sofar),
  color(Color),
  \+ prohibited(Country,Color,Sofar), writeln(Country),
  color_map([[Country,Color]|Sofar],Solution).
color_map(Solution,Solution).

prohibited(Country,Color,Sofar) :-
  borders(Country,Neighbor),
  member([Neighbor,Color],Sofar).

borders(Country,Neighbor) :- beside(Country,Neighbor).
borders(Country,Neighbor) :- beside(Neighbor,Country).

color(red).
color(blue).
color(green).
color(yellow).

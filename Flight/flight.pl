%􏰠 􏰠flight.pl
%
:- [fdata].

good_plan(Start,Goal,[Miles|Plan]) :-
  smart_planner(Goal,[0,Start],[Miles|Good]),
  reverse(Good,Plan).

smart_planner(Goal,[Miles,Goal|Cities],[Miles,Goal|Cities]).
smart_planner(Goal,[OldMiles,Current|Cities],Plan) :-
  findall(City,connected(City,Current,_),CityList),
  setof(Miles,distance(Goal,CityList,Miles),MilesList),
  member(Min,MilesList),
  distance(Next,[Goal],Min),
  connected(Current,Next,MoreMiles),
  \+ member(Next,Cities),
  NewMiles is OldMiles + MoreMiles,
  smart_planner(Goal,[NewMiles,Next,Current|Cities],Plan).

connected(City1,City2,Miles) :- data(City1,City2,Miles,y).
connected(City1,City2,Miles) :- data(City2,City1,Miles,y).

distance(City,[City|_],0).
distance(City1,[City2|_],Miles) :- data(City1,City2,Miles,_).
distance(City1,[City2|_],Miles) :- data(City2,City1,Miles,_).
distance(City,[_|RestOfCities],Miles) :- distance(City,RestOfCities,Miles).

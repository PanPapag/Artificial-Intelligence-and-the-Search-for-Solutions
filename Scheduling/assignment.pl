assignment(NP, ST, ASP, ASA) :-
  findall(activity(A,act(S,E)), activity(A,act(S,E)), Activities),
  findall(X, between(1, NP, X), Persons),
  make_tmpl(Activities, Assignments),
  length(Assignments, NoActs),
  assignment_aux(NoActs, NP, ST, Assignments),
  construct_ASA(Assignments, [], ASA),
  construct_ASP(Persons, Assignments, [], ASP), nl.

assignment_aux(_, _, _, []).
assignment_aux(Position, NP, ST, [assigned(activity(_,act(S,E)),Person)|Others]) :-
  NewPosition is Position - 1,
  assignment_aux(NewPosition, NP, ST, Others),
  select_person(Position, NP, Person),
  available(ST, S, E, Others, Person).

select_person(Position, NP, Position) :- Position < NP.
select_person(Position, NP, X) :- Position >= NP, between(1, NP, X).

available(ST, S, E, Assignments, Person) :-
  findall(activity(PA,act(PS,PE)),member(assigned(activity(PA,act(PS,PE)),Person),Assignments), PersonActivities),
  check_time_confictions(S, E, PersonActivities),
  calculate_total_time(PersonActivities, CT),
  CT + E - S =< ST.

check_time_confictions(_, _, []).

check_time_confictions(S, E, [activity(_,act(_,PE))|RestOfPersonActivities]) :-
  S - PE >= 1,
  check_time_confictions(S, E, RestOfPersonActivities).

check_time_confictions(S, E, [activity(_,act(PS,_))|RestOfPersonActivities]) :-
  PS - E >= 1,
  check_time_confictions(S, E, RestOfPersonActivities).

calculate_total_time([], 0).
calculate_total_time([activity(_,act(PS,PE))|RestOfPersonActivities], CT) :-
  calculate_total_time(RestOfPersonActivities, RCT),
  CT is PE - PS + RCT.

make_tmpl([activity(A,act(S,E))], [assigned(activity(A,act(S,E)),_)]).
make_tmpl([activity(A,act(S,E))|RestOfActivities], [assigned(activity(A,act(S,E)),_)|Partial]) :-
  make_tmpl(RestOfActivities, Partial).

construct_ASA([], Partial, ASA) :- reverse(Partial,ASA).
construct_ASA([assigned(activity(A,act(_,_)),Person)|RestOfAssignments], Partial, ASA) :-
  construct_ASA(RestOfAssignments, [A - Person|Partial], ASA).

construct_ASP([], _, Partial, ASP) :- reverse(Partial,ASP).
construct_ASP([Person|RestOfPersons], Assignments, Partial, ASP) :-
  findall(PA,member(assigned(activity(PA,act(PS,PE)),Person),Assignments), OnlyPersonActivities),
  findall(activity(PA,act(PS,PE)), member(assigned(activity(PA,act(PS,PE)),Person),Assignments), PersonActivities),
  calculate_total_time(PersonActivities, TT),
  construct_ASP(RestOfPersons, Assignments, [Person - OnlyPersonActivities - TT|Partial], ASP).

reverse(L, R) :- reverse_app(L, [], R).
reverse_app([], R, R).
reverse_app([H|L], SoFar, R) :- reverse_app(L, [H|SoFar], R).

between(I, J, I) :- I =< J.
between(I, J, X) :-
   I < J,
   I1 is I+1,
   between(I1, J, X).

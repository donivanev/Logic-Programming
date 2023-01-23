% Graph is usually defined as pair (V,E), where V is a set of vertices and E is a set of edges. 
% The edges can be represented in Prolog as facts:

edge(1, 2).

% To represent the fact that the edges are bi-directional. Not a good idea, could lead to an infinite loop

edge(X, Y) :- edge(Y, X).

% The right way

connected(X, Y) :- edge(X, Y) ; edge(Y, X).

% Path from one node to another

travel(A, B, P, [B|P]) :- connected(A, B).
travel(A, B, Visited, Path) :- connected(A, C), C \== B, \+ member(C, Visited), travel(C, B, [C|Visited], Path). 

path(A, B, Path) :- travel(A, B, [A], Q), reverse(Q, Path).

% Shortest path from one node to another

minimal([F|R], M) :- min(R, F, M).

% Minimal path
min([], M, M).
min([[P, L]|R], [_, M], Min) :- L < M, !, min(R, [P, L], Min). 
min([_|R], M, Min) :- min(R, M, Min).

shortest(A, B, Path, Length) :- setof([P, L], path(A, B, P, L), Set), Set = [_|_], minimal(Set, [Path, Length]).

% Two nodes are connected, if we can walk from one to the other, first seeding the visited list with the empty list
path(A, B) :- walk(A, B, []).           

% We can walk from A to B ... if A is connected to X, and  we haven't yet visited X, and either
% X is the desired destination OR we can get to it from X
walk(A, B, V) :- edge(A, X), not(member(X, V)), (B = X ; walk(X, B, [A|V])).       

%--------------------------------------------------------------------------------------------------------------------------------%

% Given the set of ribs E, get V the set of vertices

addV(V, VL, VR) :- not(member(V, VL)), append([V], VL, VR).
addV(V, VL, VL) :- member(V, VL).

vertices([], []).
vertices([[X, Y]|T], V) :- vertices(T, TV), addV(X, TV, TX), addV(Y, TX, V).

% Find an acyclic path in the graph
path(E, X, Y, P) :- path(E, X, Y, [], P).
path(_, _, Y, V, P) :- append([Y], _, V), reverse(V, P).
path(E, X, Y, V, P) :- member([X, Z], E),  not(member(Z, V)), path(E, Z, Y, [X|V], P).

% Has cycle

cycle(E, C) :- member([X, Y], E), X \= Y, path(E, Y, X, P1), C = [X|P1].

% Is connected

connected(V, E) :- not((member(X, V), member(Y, V), X \= Y, not(path(E, X, Y, _)))).

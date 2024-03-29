% Is list

list_is_list([]).
list_is_list([_|_]).

% First element

list_first(X, [X|_]).

% Last element

list_last(X, [X]).
list_last(X, [_|T]) :- last(X, T).

% Element at position

list_element_at(X, [X|_], 1).
list_element_at(X, [_|T], K) :- K > 1, K1 is K - 1, list_element_at(X, T, K1).

% Is member

list_member(X, [X|_]).
list_member(X, [_|T]) :- list_member(X, T).

% Concatenation

list_concat([], L, L).
list_concat([X|T], L, [X|T2]) :- list_concat(T, L, T2).
%OR
%list_append(A, T, T) :- list_member(A, T), !.
%list_append(A, T, [A|T]).

% Length

list_length([], 0).
list_length([_|T], N) :- list_length(T, N1), N is N1 + 1.

% Delete

list_delete(X, [X], []).
list_delete(X, [X|L1], L1).
list_delete(X, [Y|L2], [Y|L1]) :- list_delete(X, L2, L1).
%OR
%list_delete(X, [X|Xs], Xs).
%list_delete(X, [Y|Ys]) :- list_delete(X, Ys, Zs).

% Insert

list_insert(X, L, R) :- list_delete(X, R, L).

% Reverse

list_rev([], []).
list_rev([H|T], Reversed) :- list_rev(T, RevT), list_concat(RevT, [H], Reversed).

% Is permutation

list_perm([], []).
list_perm(L, [X|P]) :- list_delete(X, L, L1), list_perm(L1, P).
%OR
%permutation([], []).
%permutation([H|T], P):- permutation(T, Q), insert(H, Q, P).

% Remove duplicates

list_remove_duplicates([], []).
list_remove_duplicates([H|T], [H|R]) :- list_remove_duplicates(T, R), not(member(H, R)).
list_remove_duplicates([H|T], R) :- list_remove_duplicates(T, R), member(H, R).

% Shift

list_shift([H|T], Shifted) :- list_concat(T, [H], Shifted).

% Order

list_order([X, Y|T]) :- X =< Y, list_order([Y|T]).
list_order([_]).

%Sublist

sublist(R, L) :- append(_, S, L), append(R, _, S).

% Subset

list_subset([], []).
list_subset([H|T], [H|Subset]) :- list_subset(T, Subset).
list_subset([_|T], Subset) :- list_subset(T, Subset).

% Union

list_union([X|Y], Z, W) :- list_member(X, Z), list_union(Y, Z, W).
list_union([X|Y], Z, [X|W]) :- \+ list_member(X, Z), list_union(Y, Z, W).
list_union([], Z, Z).

% Intersection

list_intersect([X|Y], Z, [X|W]) :- list_member(X, Z), list_intersect(Y, Z, W).
list_intersect([X|Y], Z, W) :- \+ list_member(X, Z), list_intersect(Y, Z, W).
list_intersect([], _, []).

% Even / Odd Length

list_even_len([]).
list_even_len([_|T]) :- list_odd_len(T).

list_odd_len([_]).
list_odd_len([_|T]) :- list_even_len(T).

% Divide

list_divide([], [], []).
list_divide([X], [X], []).
list_divide([X, Y|T], [X|L1], [Y|L2]) :- list_divide(T, L1, L2).

% Min

min_(X, Y, X) :- X < Y.
min_(X, Y, Y) :- X >= Y.

list_min(X, [X]).
list_min(X, [H|T]) :- list_min(N, T), min_(H, N, X).
%OR
%list_min(L, X) :- member(X, L), \+ ((member(Y, L), X \= Y, Y < X)).

% Max 

max_(X, Y, X) :- X >= Y.
max_(X, Y, Y) :- X < Y.

list_max([X], X).
list_max([X, Y|Rest], Max) :- list_max([Y|Rest], MaxRest), max_(X, MaxRest, Max).
%OR
%list_max(L, X) :- member(X, L), \+ ((member(Y, L), X \= Y, Y > X)).

% Sum

list_sum([], 0).
list_sum([H|T], Sum) :- list_sum(T, SumTemp), Sum is H + SumTemp.

% Count occurrences of X in L

count([], _, 0).
count([H|T], H, N) :- count(T, H, M), N is M + 1.
count([H|T], X, N) :- H \= X, count(T, X, N).

% Is Preffix

list_preffix(P, L) :- list_append(P, _, L).
%OR
%list_preffix([], L).
%list_preffix([X|P], [X|L]) :- list_prefix(P, L).

% Is Suffix

list_suffix(S, L) :- list_append(_, S, L).

% Set predicates
in_union(X, A, B) :- member(X, A); member(X, B).
in_intersection(X, A, B) :- member(X, A), member(X, B).
in_difference(X, A, B) :- member(X, A), \+ member(X, B).
is_subset_of(A, B) :- \+((member(X, A), \+(member(X, B)))).
are_equal(A, B) :- is_subset_of(A, B), is_subset_of(B, A).

% Is Sublist

list_sublist(S, L) :- list_append(X, _, L), list_append(_, S, X).

% Split

list_split([], [], []).
list_split([H|T], [H|L], R) :- list_split(T, L, R).
list_split([H|T], L, [H|R]) :- list_split(T, L, R).

% Is sorted

list_sorted([]).
list_sorted([_]).
list_sorted([X, Y|L]) :- X < Y, list_sorted([Y|L]).
%OR
%is_sorted(L) :- not((append(_, [A, B|_], L), A > B)).

% Simplest sort

simplestSort(L, SL) :- permutation(L, SL), is_sorted(SL).

% Merge sort

split([], [], []).
split([X], [X], []).
split([X, Y|R], [X|Rx], [Y|Ry]) :- split(R, Rx, Ry).

merge(X, [], X).
merge([], Y, Y).
merge([X|Rx], [Y|Ry], [X|M]) :- X =< Y, merge(Rx, [Y|Ry], M).
merge([X|Rx], [Y|Ry], [Y|M]) :- X > Y, merge([X|Rx], Ry, M).

mergesort([], []).    
mergesort([X], [X]).
mergesort([X, Y|R], S) :- split([X, Y|R], L1, L2), mergesort(L1, S1), mergesort(L2, S2), merge(S1, S2, S).

% Quick sort

partition([X|T], Y, [X|T2], Z) :- X <= Y, partition(T, Y, T2, Z).
partition([X|T], Y, T2, [X|Z]) :- X > Y, partition(T, Y, T2, Z).
partition([], Y, [], []).

quicksort([X|Xs], Ys) :- partition(Xs, X, L, R), quicksort(L, Ls), quicksort(R, Rs), append(Ls, [X|Rs], Ys).
quicksort([], []).

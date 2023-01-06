% Generate natural numbers

naturals(0).
naturals(X) :- naturals(Y), X is Y + 1.

% Generate integers

integer(0, 0).
integer(X, Y) :- X > 0, (Y is X; Y is -X).

% Generate numbers in interval [X, Y].

between_(X, Y, X) :- X <= Y.
between_(X, Y, Z) :- X < Y, X1 is X + 1, between_(X1, Y, Z).

% Generate all finite lists of natural numbers

genAll([]).
genAll(L):- nat(N), between(1, N, K), S is N - K, genKS(K, S, L).

% Generate pairs of naturals

pairs(A, B) :- nat(N), between(0, N, A), B is N - A.

% Prime number

is_not_prime(X) :- X1 is X - 1, between_(2, X1), X mod Y =:= 0.

% Generate all primes

all_primes(X) :- naturals(X), X > 1, not(is_not_prime(X)).

% Factorial

factorial(0, 1).
factorial(N, X) :- M is N - 1, factorial(M, Y), X is N * Y.

% Fibonacci

fib(0, 1).
fib(Y, Z) :- fib(X, Y), Z is X + Y.
fib(X) :- fib(X, _).

% GCD of two numbers

gcd(A, 0, A).
gcd(A, B, C) :- B > 0, G is A mod B, gcd(B, G, C).

divisor(A, B, C) :- A div C =:= 0, B div C =:= 0.
common_divisors(A, B, C) :- bet2(1, A, C), divisor(A, B, C).

not_greatest_common_div(A, B, C) :- common_divisors(A, B, C), C < C1.
greatest_common_div(A, B, C) :- common_divisors(A, B, C), not(not_greatest_common_div(A, B, C)).

naturals(0).
naturals(X) :- naturals(Y), X is Y + 1.

between_(X, Y, X) :- X <= Y.
between_(X, Y, Z) :- X < Y, X1 is X + 1, between_(X1, Y, Z).

is_not_prime(X) :- X1 is X - 1, between_(2, X1), X mod Y =:= 0.
all_primes(X) :- naturals(X), X > 1, not(is_not_prime(X)).

factorial(0, 1).
factorial(N, X) :- M is N - 1, factorial(M, Y), X is N * Y.

gcd(A, 0, A).
gcd(A, B, C) :- B > 0, A >= B, A1 is A - B, gcd(A1, B, C).
gcd(A, B, C) :- A < B, gcd(B, A, C).

divisor(A, B, C) :- A div C =:= 0, B div C =:= 0.
common_divisors(A, B, C) :- bet2(1, A, C), divisor(A, B, C).

not_greatest_common_div(A, B, C) :- common_divisors(A, B, C), C < C1.
greatest_common_div(A, B, C) :- common_divisors(A, B, C), not(not_greatest_common_div(A, B, C)).

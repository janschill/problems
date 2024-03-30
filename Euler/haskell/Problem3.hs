module Problem3 where

{-
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?

https://projecteuler.net/problem=3

Solution = 6857

need atleast f_prime 20000, could be improved by generating infinite primes, until first prime factor is found
-}

holy_number = 600851475143

f_factors::Integer->[Integer]->[Integer]->[Integer]
f_factors _ [] _ = []
f_factors 1 _ factors = factors
f_factors num (x:xs) factors | mod num x == 0 = f_factors (div num x) (x:xs) ([x] ++ factors)
  | otherwise = f_factors num xs factors

f_is_prime::Integer->Bool
f_is_prime prime =
  let
    f_in_sieve::Bool
    f_in_sieve = elem prime $ f_prime prime
  in
    f_in_sieve

f_not_multiple::Integer->Integer->Bool
f_not_multiple multiple num = if mod num multiple == 0 then False else True

f_prime::Integer->[Integer]
f_prime num = f_sieve [2..num]
  where
    f_sieve [] = []
    f_sieve (x:xs) = [x] ++ f_sieve (filter (f_not_multiple $ x) (x:xs))

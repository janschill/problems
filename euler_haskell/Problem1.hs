module Problem1 where

{-
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
Find the sum of all the multiples of 3 or 5 below 1000.

https://projecteuler.net/problem=1

Solution: 233168
-}

f_sum_list::Integer
f_sum_list =
  let
    list = [1..999]

    f_multiple::[Integer]->[Integer]
    f_multiple (x:xs) = foldr (\x xs -> if (x `mod` 3 == 0 || x `mod` 5 == 0) then [x] ++ xs else xs) [] (x:xs)

    f_sum::[Integer]->Integer
    f_sum list_multiples = foldr (+) 0 list_multiples
  in
    f_sum $ f_multiple list

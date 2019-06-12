module Problem2 where

{-
Each new term in the Fibonacci sequence is generated by adding the previous two terms. By starting with 1 and 2, the first 10 terms will be:
1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms.

https://projecteuler.net/problem=2

Solution: 4613732
-}

f_sum_fibonacci::Integer
f_sum_fibonacci = foldr (+) 0 (takeWhile (< 4000000) (f_fibonacci_even_inf))

f_fibonacci_even_inf::[Integer]
f_fibonacci_even_inf = fib_inf 1
  where
    fib_inf::Integer->[Integer]
    fib_inf n = if f_fibonacci n `mod` 2 == 0 then [f_fibonacci n] ++ fib_inf (n+1) else fib_inf (n+1)

-- Fast doubling
f_fibonacci :: Integer -> Integer
f_fibonacci n | n >= 0 = fst (f_fib n)
    where
      f_fib :: Integer -> (Integer, Integer)
      f_fib 0 = (0, 1)
      f_fib n =
        let
          (a, b) = f_fib (div n 2)
          c = a * (b * 2 - a)
          d = a * a + b * b
        in if mod n 2 == 0 then (c, d) else (d, c + d)

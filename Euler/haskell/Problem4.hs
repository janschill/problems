module Problem4 where

{-
A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
Find the largest palindrome made from the product of two 3-digit numbers.

https://projecteuler.net/problem=4

Solution = 906609
-}

holy_number = 999*999

f_largest_palindrome::[Integer]
f_largest_palindrome = filter (f_factors [] [2..999]) f_palindrome_list

f_factors::[Integer]->[Integer]->Integer->Bool
f_factors _ [] _ = False
f_factors factors _ 1 = if (length factors) < 3 then True else False
f_factors factors (x:xs) num | mod num x == 0 = f_factors ([x] ++ factors) (x:xs) (div num x)
  | otherwise = f_factors factors xs num

f_palindrome_list::[Integer]
f_palindrome_list = filter (f_is_palindrome_half) [1..holy_number]
  where
    f_is_palindrome_half::Integer->Bool
    f_is_palindrome_half num = first_half == second_half
      where
        string_num = show num
        first_half = take (div (length string_num) 2) string_num
        second_half = take (div (length string_num) 2) (reverse string_num)
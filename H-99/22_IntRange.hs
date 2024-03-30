module IntRange where

intRange::Int->Int->[Int]
intRange x y | x == y = [x]
             | otherwise = x:intRange (x+1) y

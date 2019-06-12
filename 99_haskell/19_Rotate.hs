module Rotate where

rotLeft::Int->[a]->[a]
rotLeft _ [] = []
rotLeft n (x:xs) = rotLeft' n (x:xs) 0
  where
    rotLeft' n (x:xs) i | mod (n-i) (length (x:xs)) == 0 = x:(rotLeft n xs)
                        | otherwise = rotLeft' n (x:xs) (i+1)

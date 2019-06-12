module Drop where

drop'::[a]->Int->[a]
drop' [] _ = []
drop' list i = drop'' list i 0
  where
    drop'' [] _ _ = []
    drop'' (x:xs) i k | i == (k+1) = drop' xs i
                     | otherwise = x : drop'' xs i (k+1)

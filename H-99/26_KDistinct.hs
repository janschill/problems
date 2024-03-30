module KDistinct where

k_distinct::Int->[a]->[a]
k_distinct n list = list 



fak::Int->Int
fak n = n * fak (n-1)

fak'::Int->Int
fak' n = aux n 1 
  where
    aux::Int->Int->Int
    aux 0 i = i
    aux n i = aux (n-1) (n*i)

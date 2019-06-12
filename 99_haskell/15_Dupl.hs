module Dupl where

dupl::[a]->[a]
dupl [] = []
dupl (x:xs) = x:x:(dupl xs)

duplX::[a]->Int->[a]
duplX [] _ = []
duplX (y:ys) x = (f y x) ++ duplX ys x

f::a->Int->[a]
f _ 0 = []
f elem x = (f elem (x-1)) ++ [elem]

module Encode where

import Pack

encode::Eq a=>[a]->[(Int,a)]
encode list = encode' $ pack list
  where
    encode'::Eq a=>[[a]]->[(Int,a)]
    encode' [] = []
    encode' (x:xs) = [(length x,(x !! 0))] ++ encode' xs

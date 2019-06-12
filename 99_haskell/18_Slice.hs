module Slice where

slice'::Int->Int->[a]->[a]
slice' x y list = drop x (take y list)

module InsertAt where

insertAt::a->Int->[a]->[a]
insertAt elem index list = take index list ++ elem : (drop index list)

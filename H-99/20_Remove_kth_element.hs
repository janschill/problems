module Remove_kth_element where

removeKth::Int->[a]->[a]
removeKth index list = take (index-1) list ++ drop index list

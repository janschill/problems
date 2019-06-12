f::Int->[a]->a
f 0 _ = error "error"
f index list = list !! (index-1)

f::[a]->[a]
f [] = []
f (x:xs) = f xs ++ [x]

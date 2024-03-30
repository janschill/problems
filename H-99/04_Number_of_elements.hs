f::[a]->Int
f [] = 0
f (_:xs) = 1 + f xs

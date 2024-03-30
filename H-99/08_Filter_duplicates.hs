f::Eq a=>[a]->[a]
f [] = []
f (x:xs) = [x] ++ f (filter (/=x) xs)

data NestedList a = Elem a | List [NestedList a]

f::NestedList a->[a]
f (Elem a) = [a]
f (List []) = []
f (List xxs) = f' xxs
  where
    f'::[NestedList a]->[a]
    f' [] = []
    f' (x:xs) = f x ++ f' xs

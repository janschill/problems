module Tree where

data Tree a = Empty | Node a [(Tree a)]
data BinaryTree a = None | BNode (BinaryTree a) a (BinaryTree a) deriving Show

t1 = Node 5 [(Empty), (Node 2 [(Empty), (Node 1 [])]), (Node 10 [])]
l1 = [4,2,1,5,6,9,8]

hasNode::(Eq a)=>a->(Tree a)->Bool
hasNode _ Empty = False
hasNode val (Node valT trees) | val == valT = True
                              | otherwise = aux val trees
  where
    aux::(Eq a)=>a->[(Tree a)]->Bool
    aux _ [] = False
    aux val (t:ts) = hasNode val t || aux val ts

convert2List::(Tree a)->[a]
convert2List Empty = []
convert2List (Node v1 trees) = v1 : (aux trees)
    where
      aux::[(Tree a)]->[a]
      aux [] = []
      aux (t:ts) = convert2List t ++ (aux ts)

sortBinaryTree::(Ord a)=>[a]->(BinaryTree a)
sortBinaryTree [] = None
sortBinaryTree (x:xs) = BNode (sortBinaryTree (filter (x>=) xs)) x (sortBinaryTree (filter (x<) xs))

sumNodes::(Num a)=>(Tree a)->a
sumNodes Empty = 0
sumNodes (Node v trees) = v + (aux trees)
      where
        aux::(Num a)=>[(Tree a)]->a
        aux [] = 0
        aux (t:ts) = (sumNodes t) + (aux ts)
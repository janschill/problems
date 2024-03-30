module Algebra.Matrix where

import qualified Algebra.Vector as V

{-
data Matrix a =
  M {
    nrows::Int,
    ncols::Int,
    vcols::Int,
    mvect::V.Vector a
  } deriving Show

m1 = zero 5 5

zero::(Num a)=>Int->Int->(Matrix a)
zero n m = M n m m $ V.replicate' (n*m) 0
-}

-- data Matrix a =
--   M {
--     rows::Int,
--     cols::Int,
--     values::[a]
--   } deriving Show

data Matrix a =
  M {
    rows::Int,
    cols::Int,
    values::[[a]]
  } deriving Show

m1 = M 2 3 [[11,12,13],[21,22,23]]
m2 = M 2 4 [[11,12,13,14],[21,22,23,24]]
m3 = M 4 2 [[11,12],[21,22],[3,1],[3,2],[4,1],[4,2]]

{- ----------- filling ----------- -}
-- valueToMatrix::Num a=>Int->Int->a->(Matrix a)
-- valueToMatrix row col value = M row col $ replicate (row*col) value

fillMatrixValue::Num a=>Int->Int->a->(Matrix a)
fillMatrixValue r c v = M r c $ [[ x | x <- (replicate c v)] | y <- (replicate r v)]

zero::Num a=>Int->Int->(Matrix a)
zero row col = fillMatrixValue row col 0

fromArray::Num a=>[a]->(Matrix a)
fromArray values = M (length values) 1 [values]

copyMatrix::(Matrix a)->(Matrix a)
copyMatrix matrix = matrix

{- ----------- applying ----------- -}
mapMatrix::(Matrix a)->(a->a)->(Matrix a)
mapMatrix (M rows cols values) func = M rows cols [[func x | x <- v] | v <- values]

-- multiplyMatrix::Num a=>(Matrix a)->(Matrix a)->(Matrix a)
-- -- multiplyMatrix (M rows1 cols1 []) (M rows2 cols2 values2) = (M rows2 cols2 values2)
-- -- multiplyMatrix (M rows1 cols1 values1) (M rows2 cols2 []) = (M rows2 cols2 values1)
-- multiplyMatrix (M rows1 cols1 values1) (M rows2 cols2 values2) = if cols1 == rows2 then M rows1 cols1 (aux (M rows1 cols1 values1) (transpose (M rows2 cols2 values2)) []) else error "not matching rows/cols"
--                                                                   where
--                                                                     aux::Num a=>(Matrix a)->(Matrix a)->[a]->[a]
--                                                                     aux (M _ _ []) (M _ _ [])  values = values
--                                                                     aux m1 m2 values = aux' m1 m2 values 0 0

--                                                                     aux'::Num a=>(Matrix a)->(Matrix a)->[a]->Int->Int->[a]
--                                                                     aux' m1 m2 values rowM1 colM1 rowM2 colM2 | colM2 < (cols m2) = aux m1 m2 (values ++ (valueAtIndex m1 (row, col) + valueAtIndex m2 (row, col))) rowM1 (colM1+1) rowM2 (colM2+1)
--                                                                                                               | colM2 < (cols m2) = aux m1 m2 (values ++ (valueAtIndex m1 (row, col) + valueAtIndex m2 (row, col))) rowM1 (colM1+1) rowM2 (colM2+1)
--                                                                                                               | aux m1 m2 (values ++ (valueAtIndex m1 (row, col) + valueAtIndex m2 (row, col))) (row) (col+1)



multiplyByScalar::Num a=>(Matrix a)->a->(Matrix a)
multiplyByScalar m1 scalar = mapMatrix m1 (scalar*)

addMatrix::(Num a)=>(Matrix a)->(Matrix a)->(Matrix a)
addMatrix (M rows1 cols1 values1) (M rows2 cols2 values2)
  | rows1 == rows2 &&
    cols1 == cols2 = M rows1 cols1 (aux values1 values2 [])
     where
       aux::Num a=>[[a]]->[[a]]->[[a]]->[[a]]
       aux [] [] values = values
       aux (x:xs) (y:ys) values = aux xs ys (values ++ [(map (\(p, q) -> p + q) $ zip x y)])

subtractMatrix::(Num a)=>(Matrix a)->(Matrix a)->(Matrix a)
subtractMatrix (M rows1 cols1 values1) (M rows2 cols2 values2)
  | rows1 == rows2 &&
    cols1 == cols2 = M rows1 cols1 (aux values1 values2 [])
     where
       aux::Num a=>[[a]]->[[a]]->[[a]]->[[a]]
       aux [] [] values = values
       aux (x:xs) (y:ys) values = aux xs ys (values ++ [(map (\(p, q) -> p - q) $ zip x y)])

{- in-place matrix transposition (row-major order) – O(n^2) runtime :/ -}
transpose :: Matrix a -> Matrix a
transpose (M r c as) = M c r (trans as)
    where trans [] = []
          trans xs = map head xs : trans (map tail xs)

-- transpose::(Matrix a)->(Matrix a)
-- transpose (M rows cols values) = M cols rows (aux values 0 0 [])
--   where
--     aux::[a]->Int->Int->[a]->[a]
--     aux values row col transposed | cols > col =
--                                     if rows > row then aux values (row+1) col (transposed ++ [valueAtIndex (M rows cols values) (row,col)])
--                                                   else aux values 0 (col+1) transposed
--                                   | otherwise = transposed

dotProd :: Num a => [a] -> [a] -> a
dotProd xs ys = sum (zipWith (*) xs ys)

multiplyMatrix :: Num a => Matrix a -> Matrix a -> Matrix a
multiplyMatrix (M r ca xss) (M ra c xss2) | ca /= ra = error "Invalid matrix shapes"
                                          | otherwise = M r c (matmul xss)
              where (M c rb yss) = transpose (M ra c xss2)
                    matmul [] = []
                    matmul (xs:xss) = generaterow yss xs : matmul xss
                    generaterow [] _ = []
                    generaterow (ys:yss) xs = dotProd xs ys : generaterow yss xs

{- ----------- indexing ----------- -}
-- valueAtIndex::(Matrix a)->(Int, Int)->a
-- valueAtIndex (M rows cols values) (row, col) | rows <= row || cols <= col = error "indices too large for given Matrix"
--                                              | otherwise = values !! (cols * row + col)


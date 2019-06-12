module MatrixM where

data Matrix a = M {
  rows :: Int,
  cols :: Int,
  values :: [[a]]
} deriving Show

m1 = M 1 2 [[1,2]]
m2 = M 2 1 [[1],[2]]

transpose :: Matrix a -> Matrix a
transpose (M r c as) = M c r (trans as)
trans [] = []
trans xs = map head xs : trans (map tail xs)

dot_prod :: Num a => [a] -> [a] -> a
dot_prod xs ys = sum (zipWith (*) xs ys)

mat_mul :: Num a => Matrix a -> Matrix a -> Matrix a
mat_mul (M r ca xss) (M rb cb yss) | ca /= rb = error "Invalid matrix shapes"
                        | otherwise = M r c (matmul xss)
    where (M c rb yss) = transpose (M rb cb yss)
          matmul [] = []
          matmul (xs:xss) = generaterow yss xs : matmul xss
          generaterow [] _ = []
          generaterow (ys:yss) xs = dot_prod xs ys : generaterow yss xs
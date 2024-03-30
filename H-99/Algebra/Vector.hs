module Algebra.Vector (
Vector,
replicate',
maximum'
) where


data Vector3 a =
  Vector3
  {
    x::a,
    y::a,
    z::a
  }

v1 = Vector3 1 2 3
v2 = Vector3 3 2 1

instance Show a => Show (Vector3 a) where
  show (Vector3 x y z) = "[" ++ (show x) ++ "," ++ (show y) ++ "," ++ (show z) ++ "]"

instance Num a => Num (Vector3 a) where
  (+) (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = Vector3 (x1+x2) (y1+y2) (z1+z2)
  (-) (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = Vector3 (x1-x2) (y1-y2) (z1-z2)

class VectorOperations a where
  dot::(Vector3 a)->(Vector3 a)->a
  cross::(Vector3 a)->(Vector3 a)->(Vector3 a)
  vmult::(Vector3 a)->a->(Vector3 a)
  mag::(Vector3 a)->Float

instance VectorOperations Integer where
  dot   (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = (x1*x2) + (y1*y2) + (z1*z2)
  cross (Vector3 x1 y1 z1) (Vector3 x2 y2 z2) = Vector3 (aux (y1,z1) (z2,y2)) (aux (z1,x1) (x2,z2)) (aux (x1,y1) (y2,x2))
    where
      aux::(Integer, Integer)->(Integer, Integer)->Integer
      aux (v1,v2) (v3,v4) = (v1*v3) - (v2*v4)

  vmult (Vector3 x1 y1 z1) value = Vector3 (x1*value) (y1*value) (z1*value)
  mag   (Vector3 x1 y1 z1) = sqrt $ fromIntegral $ (x1^2) + (y1^2) + (z1^2)


data Vector a = V {
    rows::Int,
    values::[a]
  }

v3 = V 10 [1..10]

instance Show a => Show (Vector a) where
  show (V rows values) = show values

maximum'::(Ord a)=>(Vector a)->a
maximum' (V _ [v]) = v
maximum' (V _ (v:v':vs)) | v >= v' = maximum' (V 0 (v:vs))
                        | otherwise = maximum' (V 0 (v':vs))

replicate'::Num a=>Int->a->Vector a
replicate' rows value = V rows $ replicate rows value
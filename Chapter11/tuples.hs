-- file: tuples.hs


import Data.Array.Accelerate as A
import Data.Array.Accelerate.CUDA

f1 :: (Exp Int, Exp Int) -> Acc (Scalar Int)
f1 (x, y) = unit (x + y)

f2 :: Exp (Int, Int) -> Acc (Scalar Int)
f2 e = let (x, y) = unlift e :: (Exp Int, Exp Int)
           in unit (x + y)

main = let
    xs = [run $ f1 (x, y) | x <- [1..10], y <- [1..10]] 
    ys = [run $ f2 $ lift ((x, y) :: (Int, Int)) | x <- [1..10], y <- [1..10]] 
    in print xs

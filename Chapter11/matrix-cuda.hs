-- file: matrix-cuda.hs

{-# LANGUAGE TypeOperators #-}

import Data.Array.Accelerate as A
import Data.Array.Accelerate.CUDA

type Matrix = Array DIM2 Double

matProduct :: Acc Matrix -> Acc Matrix -> Acc Matrix
matProduct a b = let

    Z :. mx :. _ = unlift (shape a)  :: Z :. Exp Int :. Exp Int
    Z :. _ :. my = unlift (shape b)  :: Z :. Exp Int :. Exp Int

    aRep = A.replicate (lift $ Z :. All :. my  :. All) a
    bRep = A.replicate (lift $ Z :. mx  :. All :. All) (A.transpose b)

    in A.fold (+) 0
        $ A.zipWith (*) aRep bRep

main = let
    mat :: Matrix
    mat = fromList (Z :. 100 :. 100) [1..]

    res = run $ A.sum $ matProduct (lift mat) (lift mat)

   in print res

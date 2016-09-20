-- file: matrix-fixed.hs

{-# LANGUAGE TypeOperators #-}

import Data.Array.Accelerate as A

type Matrix = Array DIM2 Double

matProduct :: Acc Matrix -> Acc Matrix -> Acc Matrix
matProduct a b = let

    Z :. mx :. _ = unlift (shape a)  :: Z :. Exp Int :. Exp Int
    Z :. _ :. my = unlift (shape b)  :: Z :. Exp Int :. Exp Int

    aRep = A.replicate (lift $ Z :. All :. my  :. All) a
    bRep = A.replicate (lift $ Z :. mx  :. All :. All) (A.transpose b)

    in A.fold (+) 0
        $ A.zipWith (*) aRep bRep

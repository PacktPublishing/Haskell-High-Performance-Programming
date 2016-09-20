-- file: matrix.hs

{-# LANGUAGE TypeOperators #-}

import Data.Array.Accelerate as A

type Matrix = Array DIM2 Double

matProduct :: Acc Matrix -> Acc Matrix -> Acc Matrix
matProduct a b = let

    Z :. mx :. _ = unlift (shape a) :: Z :. Exp Int :. Exp Int
    Z :. _ :. my = unlift (shape b) :: Z :. Exp Int :. Exp Int

    in generate (index2 mx my) $ \ix ->
        let Z :. x :. y = unlift ix :: Z :. Exp Int :. Exp Int
            s1 = lift (Z :. x :. All)
            s2 = lift (Z :. All :. y)
            in the $ A.sum $ A.zipWith (*) (slice a s1) (slice b s2)

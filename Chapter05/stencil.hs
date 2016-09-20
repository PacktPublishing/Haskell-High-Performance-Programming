{-# LANGUAGE QuasiQuotes #-}

import Data.Array.Repa as Repa
import Data.Array.Repa.Stencil
import Data.Array.Repa.Stencil.Dim2
import Data.Bits ((.|.))

image :: Array D DIM2 Double
image = fromFunction (ix2 5 5) $
    \(Z :. x :. y) -> if x == 0 || x == 2 || y == 2 then 1 else 0

stencil :: Stencil DIM2 Double
stencil = [stencil2| 0  0  0
                     1  1  1
                     0  0  0 |]

stencil' :: Stencil DIM2 Double
stencil' = [stencil2| -1  1 -1
                      -2  1 -2
                      -1  1 -1 |]
 
st1, st2 :: Array PC5 DIM2 Int
st1 = Repa.smap (\x -> if x >= 3 then 1 else 0) $
      mapStencil2 BoundClamp stencil image

st2 = Repa.smap (\x -> if x >= 1 then 1 else 0) $
      mapStencil2 BoundClamp stencil' image

main = print $ head $ computeUnboxedP $ Repa.szipWith (.|.) st1 st2

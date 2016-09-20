-- file: bubblesort-optimized.hs

import Data.Vector.Unboxed as V
import Data.Vector.Unboxed.Mutable as MV

import Control.Monad.ST
import System.Random (randomIO) -- for testing

bubblesortM v = loop where
    indices = V.enumFromTo 1 (MV.length v - 1)
  
    loop = do swapped <- V.foldM' f False indices 
              if swapped then loop else return ()
  
    f swapped i = do
        a <- MV.unsafeRead v (i-1)
        b <- MV.unsafeRead v i
        if a > b then MV.unsafeSwap v (i-1) i >> return True
                 else return swapped

bubblesort v = runST $ do
    mv <- V.thaw v
    bubblesortM mv
    V.unsafeFreeze mv

main = do
    v <- V.generateM 10000 $ \_ -> randomIO :: IO Double
    let v_sorted = bubblesort v
        median   = v_sorted ! 5000
    print median

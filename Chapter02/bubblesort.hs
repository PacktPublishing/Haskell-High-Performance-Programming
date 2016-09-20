-- file: bubblesort.hs

import Data.Vector as V
import Data.Vector.Mutable as MV

import Control.Monad.ST
import System.Random (randomIO) -- for testing
-- import Control.Monad.Primitive (PrimMonad(PrimState))

-- unboxed: bubblesortM :: (Ord a, Unbox a, PrimMonad m) => MVector (PrimState m) a -> m ()
-- boxed: bubblesortM :: (Ord a, PrimMonad m) => MVector (PrimState m) a -> m ()
bubblesortM v = loop where
    indices = V.fromList [1 .. MV.length v - 1]
  
    loop = do swapped <- V.foldM' f False indices 
              if swapped then loop else return ()
  
    f swapped i = do
        a <- MV.read v (i-1)
        b <- MV.read v i
        if a > b then MV.swap v (i-1) i >> return True
                 else return swapped

-- boxed:   bubblesort :: Ord a => Vector a -> Vector a
-- unboxed: bubblesort :: (Ord a, Unbox a) => Vector a -> Vector a
bubblesort v = runST $ do
    mv <- V.thaw v
    bubblesortM mv
    V.freeze mv

main = do
    v <- V.generateM 10000 $ \_ -> randomIO :: IO Double
    let v_sorted = bubblesort v
        median   = v_sorted ! 5000
    print median

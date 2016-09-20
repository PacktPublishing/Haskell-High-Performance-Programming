-- file: map-fib.hs

import Data.IntMap as IM

fib :: Int -> IntMap Int
fib n = m where
    m = IM.fromList $ (1,1) : (2,1) :
        [ (i, IM.findWithDefault 0 (i-1) m + IM.findWithDefault 0 (i-2) m)
        | i <- [3..n] ]

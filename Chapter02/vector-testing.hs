-- file: vector-testing.hs

import qualified Data.Vector.Unboxed as U
import System.Random (randomIO)

type Obs = U.Vector (TimeStamp, Double)

type TimeStamp = Int
type Period = Int

-- | O(1)
values :: Obs -> U.Vector Double
values obs = snd (U.unzip obs)

-- | O(n+m), no copying.
window :: TimeStamp -> TimeStamp -> Obs -> Obs
window from until v =
    let (_, start)   = U.span ((< from) . fst) v
        (between, _) = U.span ((<= until) . fst) start
        in between

-- | O(n)
average :: Obs -> Double
average obs = U.sum (values obs) / fromIntegral (U.length (values obs))

main = do
    obs <- U.generateM (1024 ^ 2) $ \i -> randomIO >>= \v -> return (i, v)
    print $ average $ window 1 (1024 ^ 2) obs
    print $ average $ window 2 (1023 ^ 2) obs
    print $ average $ window 3 (1022 ^ 2) obs
    print $ average $ window 4 (1021 ^ 2) obs

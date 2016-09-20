-- file: mr.hs

import qualified Data.List

main = do
    -- let f = (1 +)
    -- let f = \x -> 1 + x
    let f x = (1 + x)

    print $ f (6   :: Int)
    print $ f (0.1 :: Double)

    let len = Data.List.genericLength [1..1000]
    print (len, len)

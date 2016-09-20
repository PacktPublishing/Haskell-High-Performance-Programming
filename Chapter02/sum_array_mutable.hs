-- file: sum_array_mutable.hs
{-# LANGUAGE FlexibleContexts #-}

import Control.Monad.ST
import Data.Array.ST

count_stuarray :: Int -> Int
count_stuarray n = runST $ do
    ref <- newArray (0,0) 0 :: ST s (STUArray s Int Int)
    let go 0 = readArray ref 0
        go i = do s <- readArray ref 0
                  writeArray ref 0 $ s + i
                  go (i-1)
    go n

main = print $ count_stuarray 10000000

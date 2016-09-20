-- file: sum_mutable.hs

import Control.Monad.ST
import Data.IORef
import Data.STRef

count_st :: Int -> Int
count_st n = runST $ do
    ref <- newSTRef 0
    let go 0 = readSTRef ref
        go i = modifySTRef' ref (+ i) >> go (i - 1)
    go n

count_io :: Int -> IO Int
count_io n = do
    ref <- newIORef 0
    let go 0 = readIORef ref
        go i = modifyIORef' ref (+ i) >> go (i - 1)
    go n

count_pure :: Int -> Int
count_pure n = go n 0 where
    go 0 s = s
    go i s = go (i - 1) $! (s + i)

main =
    -- print $ count_st 10000000 -- 160 MB
    -- count_io 10000000 >>= print -- 160 MB
    print $ count_pure 10000000 -- 51.8 KB

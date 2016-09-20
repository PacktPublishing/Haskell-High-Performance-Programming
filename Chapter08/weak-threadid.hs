-- file: weak-threadid.hs

import System.Mem.Weak
import Control.Concurrent
import Control.Concurrent.MVar

main = do
    tid <- forkFinally (do { var <- newEmptyMVar
                           ; takeMVar (var :: MVar ())
                           }) print >>= mkWeakThreadId
    threadDelay 10000000
    print =<< deRefWeak tid

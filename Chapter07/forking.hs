-- file: forking.hs

import Control.Concurrent

-- outputs nothing
test1 = do
    tid <- forkIO $ threadDelay 100000000
    killThread tid

-- outputs exception: Prelude.undefined
test2 = do
    tid <- forkIO $ undefined
    killThread tid

-- waits for the thread to exit
test3 = do
    mvar <- newEmptyMVar
    tid <- threadDelay 5000000 `forkFinally` \_ -> putMVar mvar ()
    takeMVar mvar

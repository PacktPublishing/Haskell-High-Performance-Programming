-- file: mvar-async.hs

import Control.Concurrent
import Control.Exception

doAsync :: MVar a -> IO a -> IO ThreadId
doAsync mvar job = forkIO $ do
    r <- job
    putMVar mvar r

main = do
    mvars <- sequence [newEmptyMVar, newEmptyMVar]
    sequence [ doAsync mvar getLine | mvar <- mvars ]
    results <- mapM takeMVar mvars
    print results

doAsyncSafe :: MVar (Either SomeException a) -> IO a -> IO ThreadId
doAsyncSafe mvar job = mask_ $ forkIOWithUnmask $ \unmask ->
    do { r <- unmask job; putMVar mvar (Right r) }
    `catch` \e -> putMVar mvar (Left e)

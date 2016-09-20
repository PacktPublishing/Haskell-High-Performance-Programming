-- file: stm-either.hs

import Control.Concurrent
import Control.Concurrent.STM

eitherOr :: IO a -> IO b -> IO (Either a b)
eitherOr job_a job_b = do
    a <- doAsyncSTM job_a
    b <- doAsyncSTM job_b
    atomically $ fmap Left (takeTMVar a) `orElse` fmap Right (takeTMVar b)

doAsyncSTM :: IO a -> IO (TMVar a)
doAsyncSTM job = do
    tmvar <- newEmptyTMVarIO
    forkIO $ do r <- job
                atomically $ putTMVar tmvar r
    return tmvar

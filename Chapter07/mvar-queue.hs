-- file: mvar-queue.hs

import Control.Concurrent.MVar

data Queue a = Queue (MVar [a]) (MVar [a])

newQueue :: IO (Queue a)
newQueue = Queue <$> newMVar [] <*> newMVar []

enqueue :: Queue a -> a -> IO ()
enqueue (Queue _ ys_var) x = modifyMVar_ ys_var (return . (x :))

dequeue :: Queue a -> IO (Maybe a)
dequeue (Queue xs_var ys_var) = modifyMVar xs_var $ \xs_q ->
    case xs_q of
        x : xs -> return (xs, Just x)
        []     -> modifyMVar ys_var $ \ys_q ->
            return $ case reverse ys_q of
                []     -> ([], ([], Nothing))
                x : xs -> ([], (xs, Just x))

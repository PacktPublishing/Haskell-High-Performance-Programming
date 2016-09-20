-- file: mvar-reserve.hs

import Control.Exception (bracket)
import Control.Concurrent (forkIO)
import Control.Concurrent.MVar

printing lock str =
    bracket (takeMVar lock) (\i -> putMVar lock $! i+1) (\_ -> print str)

main = do
    lock <- newMVar 1 :: IO (MVar Int)
    forkIO $ printing lock "output a"
    forkIO $ printing lock "output b"
    forkIO $ printing lock "output c"
    takeMVar lock >>= print

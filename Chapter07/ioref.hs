-- ioref.hs

import Data.IORef
import Control.Concurrent

fun ref c = do
    x <- readIORef ref
    writeIORef ref c
    putStr x
    fun ref c

main = do
    ref <- newIORef "a"
    forkIO $ fun ref "a"
    forkIO $ fun ref "b"
    threadDelay 5000

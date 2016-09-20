-- file: io-streams.hs

import           Data.IORef (newIORef, readIORef, writeIORef)
import           Control.Monad.IO.Class (liftIO)
import           System.IO.Streams (Generator, InputStream, OutputStream)
import qualified System.IO.Streams as S
import           System.Random (randomIO)

randomInputStreamRef :: Int -> IO (InputStream Double)
randomInputStreamRef count = do
    ref <- newIORef count
    S.makeInputStream $ do
        n <- readIORef ref
        if n <= 0
            then return Nothing
            else do writeIORef ref $! n - 1
                    r <- randomIO
                    return (Just r)

randomInputStreamGen :: Int -> IO (InputStream Double)
randomInputStreamGen count = S.fromGenerator (go count)
  where
    go :: Int -> Generator Double ()
    go 0 = return ()
    go n = liftIO randomIO >>= S.yield >> go (n - 1)

randomInputStreamAna :: Int -> IO (InputStream Double)
randomInputStreamAna count = S.unfoldM go count
  where
    go 0 = return Nothing
    go n = randomIO >>= \r -> return (Just (r, n - 1))

main = randomInputStreamRef 500000 >>= S.fold (+) 0 >>= print

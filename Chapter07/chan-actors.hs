-- file: chan-actors.hs

import Data.List (isPrefixOf)
import Control.Monad
import Control.Concurrent
import Control.Concurrent.Chan

client :: Int -> Chan String -> IO ()
client i chan = go where
    go = do input <- readChan chan
            if input == ("request " ++ show i)
                then writeChan chan ("response " ++ show i)
                else return ()
            go

main = do
    chan <- newChan
    chans <- replicateM 3 (dupChan chan)
    zipWithM_ (\i c -> forkIO $ client i c) [1..] chans

    forM_ [1..3] $ writeChan chan . ("request " ++) . show
    getChanContents chan >>= mapM_ print . filter (isPrefixOf "response")

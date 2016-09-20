-- file: client-server.hs
{-# LANGUAGE BangPatterns #-}

import Control.Monad
import Control.Distributed.Process
import Control.Distributed.Process.Node (initRemoteTable)
import Control.Distributed.Process.Backend.SimpleLocalnet

master :: Process ()
master = do
    ports <- replicateM 100 $ do
        (sendport, recvport) <- newChan
        _pid <- spawnLocal (client sendport)
        return recvport

    port <- mergePortsRR ports
    let loop !s = do
            mn <- receiveChanTimeout 1000 port
            case mn of
                Just n -> loop (s + n)
                Nothing -> do say $ "final: " ++ show s
                              terminate
    loop 0
    
client :: SendPort Double -> Process ()
client sendport = forM_ [1..100] (sendChan sendport)

main = do
    backend <- initializeBackend "localhost" "9001" initRemoteTable
    startMaster backend (\_ -> master)

-- file: remote-exec.hs
{-# LANGUAGE TemplateHaskell, KindSignatures #-}

import Data.Typeable

import Control.Distributed.Process
import Control.Distributed.Process.Closure
import Control.Distributed.Process.Node (initRemoteTable)
import Control.Distributed.Process.Backend.SimpleLocalnet

rpc :: String -> Process Int
rpc str = return (length str)

remotable ['rpc]

foo :: Process ()
foo = do
    node <- getSelfNode
    str <- call $(functionTDict 'rpc) node ($(mkClosure 'rpc) "foo")
    say (show str)

main :: IO ()
main = do
    backend <- initializeBackend "localhost" "9001" (__remoteTable initRemoteTable)
    startMaster backend $ \_ -> foo

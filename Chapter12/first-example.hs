-- file: first-exmaple.hs
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TemplateHaskell #-}

import Control.Distributed.Process
import Control.Distributed.Process.Closure
import Control.Distributed.Process.Node (initRemoteTable)
import Control.Distributed.Process.Backend.SimpleLocalnet

import Data.Binary   (Binary)
import Data.Typeable (Typeable)
import GHC.Generics  (Generic)

data SummerMsg = Add Int ProcessId
               | Value Int
               deriving (Show, Typeable, Generic)

instance Binary SummerMsg

summerProc :: Process ()
summerProc = go 0
  where
    go s = do msg@(Add num from) <- expect
              say $ "received msg: " ++ show msg
              let s' = s + num
              send from (Value s')
              go s'

remotable ['summerProc]

summerTest :: Process ()
summerTest = do
    node <- getSelfNode
    summerPid <- spawn node $(mkStaticClosure 'summerProc)

    mypid <- getSelfPid

    send summerPid (Add 5 mypid)
    send summerPid (Add 7 mypid)

    Value n <- expect
    say $ "updated value: " ++ show n
    Value n' <- expect
    say $ "updated value: " ++ show n'

main :: IO ()
main = do
    backend <- initializeBackend "localhost" "9001" (__remoteTable initRemoteTable)
    startMaster backend $ \_ -> summerTest

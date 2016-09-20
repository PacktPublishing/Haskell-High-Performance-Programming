-- file: bi-directional.hs

import Control.Distributed.Process
import Control.Distributed.Process.Node (initRemoteTable)
import Control.Distributed.Process.Backend.SimpleLocalnet

server :: Process ()
server = do
    pid <- getSelfPid
    (sendport', recvport) <- newChan
    _clientPid <- spawnLocal (client pid sendport')
    sendport <- expect

    -- server: send via sendport, receive via recvport
    sendChan sendport "ping"
    receiveChan recvport >>= say

client :: ProcessId -> SendPort String -> Process ()
client pid sendport = do
    (sendport', recvport) <- newChan
    send pid sendport'

    -- client: send via sendport, receive via recvport
    ping <- receiveChan recvport
    sendChan sendport ("pong: " ++ ping)

main = do
    backend <- initializeBackend "localhost" "9001" initRemoteTable
    startMaster backend (\_ -> server)

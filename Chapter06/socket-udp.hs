-- file: socket-udp.hs
{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (forever)
import System.Socket
import System.Socket.Protocol.UDP (UDP)
import System.Socket.Type.Datagram (Datagram)
import System.Socket.Family.Inet (Inet, SocketAddress(..), inetLoopback)

server = do
    s <- socket :: IO (Socket Inet Datagram UDP)
    bind s (SocketAddressInet inetLoopback 3003)
    forever $ do
        (msg, addr) <- receiveFrom s 1024 mempty
        sendTo s msg mempty addr

client = do
    s <- socket :: IO (Socket Inet Datagram UDP)
    connect s (SocketAddressInet inetLoopback 3003)
    send s "ping" mempty
    receive s 1024 mempty >>= print

    -- sendTo s "ping" mempty  (SocketAddressInet inetLoopback 3003)

-- Run server via runghc and client from GHCi separetely, for example.
main = server

-- file: socket-echo.hs

import Control.Exception
import Network.Socket

server = bracket
    (socket AF_UNIX Stream defaultProtocol)
    close
    (\s -> do
        bind s (SockAddrUnix "./echo.socket")
        listen s 1
        (conn, _) <- accept s
        talk conn)
  where
    talk s = do r <- recv s 1024
                putStrLn r
                send s r
                talk s

client = do
    s <- socket AF_UNIX Stream defaultProtocol
    connect s (SockAddrUnix "./echo.socket")
    send s "ping"
    pong <- recv s 1024
    putStrLn pong

main =
    server
    -- client

-- file: async-cli.hs

import Control.Monad (forever)
import Control.Concurrent
import Control.Concurrent.Async

main1 = forever $
    withAsync getLine $ \userInput ->
    withAsync (threadDelay 5000000) $ \timeOut -> do
        res <- waitEither userInput timeOut
        case res of
            Left input -> print input
            Right _ -> putStrLn "Timeout!"

main2 = forever $ do
    res <- withAsync getLine $ \userInput ->
           withAsync (threadDelay 5000000) $ \timeOut ->
           waitEither userInput timeOut
    case res of
        Left input -> print input
        Right _ -> putStrLn "Timeout!"

main3 = forever $ do
    res <- getLine `race` threadDelay 5000000
    case res of
        Left input -> print input
        Right _ -> putStrLn "Timeout!"

main = main3

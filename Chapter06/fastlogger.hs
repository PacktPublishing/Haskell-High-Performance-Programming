-- file: fastlogger.hs
{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid
import System.Log.FastLogger

type MyLogger = String -> IO ()

app :: MyLogger -> IO ()
app log = do
    log "Haskell is fun"
    log "and logging is fun too!"

main = do
    getTimeStamp <- newTimeCache "%Y-%M-%d %H:%m"
    withTimedFastLogger getTimeStamp (LogStdout defaultBufSize) $
        \logger -> app (logger . logFormat) 

logFormat :: String -> FormattedTime -> LogStr
logFormat msg time = toLogStr time <> ": " <> toLogStr msg <> "\n"

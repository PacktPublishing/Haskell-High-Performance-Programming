-- file: monadlogger.hs
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveFunctor #-}

import Control.Monad.Logger
import Data.Monoid
import System.Log.FastLogger

type MyLogger = LogStr -> IO ()

newtype App a = App { unApp :: MyLogger -> IO a }
                deriving (Functor)

instance Applicative App where
    pure x = App $ \_ -> pure x
    App f <*> (App g) = App $ \log -> f log <*> g log

instance Monad App where
    App f >>= g = App $ \log -> do r <- f log
                                   unApp (g r) log

instance MonadLogger App where
    monadLoggerLog _ _ _ msg = App $ \log -> log (toLogStr msg)

app :: App ()
app = do
    logInfoN "Haskell is fun"
    logInfoN "and logging is fun too!"

logFormat :: LogStr -> FormattedTime -> LogStr
logFormat msg time = toLogStr time <> ": " <> msg <> "\n"

main = do
    getTimeStamp <- newTimeCache "%Y-%M-%d %H:%m"
    withTimedFastLogger getTimeStamp (LogStdout defaultBufSize) $
        \logger -> unApp app (logger . logFormat) 

-- file: logging-t.hs

{-# LANGUAGE TemplateHaskell #-}

import Data.Text (pack)
import Control.Monad
import Control.Monad.Logger

app :: LoggingT IO ()
app = replicateM_ 500000 $ $logInfo (pack "msg")

main = runStdoutLoggingT app2

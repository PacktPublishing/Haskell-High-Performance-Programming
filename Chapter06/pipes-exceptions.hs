-- file: pipes-exceptions.hs

import Control.Exception
import Pipes
import GHC.IO.Exception (IOException(..))

tolerantStdinLn :: Producer' String IO ()
tolerantStdinLn = do
    x <- lift $ try readLn
    case x of
        Left e@IOError{} -> return ()
        Right ln -> yield ln >> tolerantStdinLn

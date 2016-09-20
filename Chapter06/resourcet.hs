-- file: resourcet.hs

import Control.Exception

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.Resource
import System.IO

copy_resourcet :: ResIO ()
copy_resourcet = do
    (_, f1) <- allocate (openFile "read.txt" ReadMode) hClose
    (_, f2) <- allocate (openFile "write.txt" WriteMode) hClose
    liftIO $ hGetContents f1 >>= hPutStr f2

main = runResourceT copy_resourcet

copy_bracket :: IO ()
copy_bracket =
    bracket (openFile "read.txt" ReadMode) hClose $ \f1 ->
    bracket (openFile "write.txt" WriteMode) hClose $ \f2 ->
        hGetContents f1 >>= hPutStr f2

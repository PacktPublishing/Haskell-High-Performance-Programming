
import Control.Monad (replicateM_)
import Data.IORef

main = do
    counter <- newIORef 0
    replicateM_ 10000000 (modifyIORef counter (+1))
    print =<< readIORef counter

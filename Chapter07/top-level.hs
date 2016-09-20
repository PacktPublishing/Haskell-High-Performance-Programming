
import Data.IORef
import System.IO.Unsafe (unsafePerformIO)
import Control.Concurrent.STM

globalVar :: IORef Int
globalVar = unsafePerformIO (newIORef 0)


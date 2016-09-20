-- file: echo-t.hs

import System.IO
import qualified Data.Text.Lazy.IO as T

main = T.getContents >>= T.putStr


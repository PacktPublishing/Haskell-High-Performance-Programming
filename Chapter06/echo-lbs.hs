-- file: echo-lbs.hs

import System.IO
import qualified Data.ByteString.Lazy as L

main = do
    hSetBinaryMode stdin True
    hSetBinaryMode stdout True
    L.getContents >>= L.putStr

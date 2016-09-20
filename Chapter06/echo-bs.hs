-- file: echo-bs.hs

import System.IO
import qualified Data.ByteString as B

main = do
    hSetBinaryMode stdin True
    hSetBinaryMode stdout True
    B.getContents >>= B.putStr

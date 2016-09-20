-- file: bytestring-perf.hs
-- ghc -rtsopts -O bytestring-perf.hs && time ./bytestring-perf +RTS -s < /dev/zero

import qualified Data.ByteString as B
import System.IO (stdin)

go :: Int -> Int -> IO Int
go 0 s = return $! s
go n s = do bs <- B.hGet stdin (1024 * 1024)
            go (n-1) $! B.length bs + s

main = go 2048 0 >>= print

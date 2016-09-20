-- file: bytestring-lazy-perf.hs

import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString as S
import System.IO (stdin)

size = 2048 * 1024 * 1024

go :: Int -> [S.ByteString] -> Int
go s (c:cs) | s >= size = s
            | otherwise = go (s + S.length c) cs

main = do
    bs <- B.hGetContents stdin
    print $ go 0 (B.toChunks bs)

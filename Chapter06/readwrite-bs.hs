-- file: readwrite-bs.hs
{-# LANGUAGE OverloadedStrings #-}
import System.IO
import qualified Data.ByteString as B

main = do
    hSetBinaryMode stdin True
    hSetBinaryMode stdout True
    B.writeFile "file.txt" "old"
    old <- B.readFile "file.txt"
    B.writeFile "file.txt" "new"
    B.putStr old
    

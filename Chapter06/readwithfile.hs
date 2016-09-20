-- file: readwithfile.hs

import System.IO

main = do
    old <- withFile "file.txt" ReadWriteMode hGetContents
    putStrLn old

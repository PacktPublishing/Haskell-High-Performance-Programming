-- file: readwrite.hs

main = do
    writeFile "file.txt" "old"
    old <- readFile "file.txt"
    writeFile "file.txt" "new"
    putStrLn old
    

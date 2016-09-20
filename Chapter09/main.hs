-- file: main.hs

foo :: Int -> Int
foo 1 = 1
foo n = n * foo (n - 1)

main = do
    line <- getLine
    print $ foo (read line)

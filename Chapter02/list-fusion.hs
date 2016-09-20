-- file: list-fusion.hs

inc :: [Int] -> [Int]
inc (x:xs) = x + 1 : inc xs
inc     [] = []

summer :: Int -> [Int] -> [Int]
summer a (x:xs) = let r = a + x in r `seq` r : summer r xs
summer _     [] = []

main = do
    -- print $ sum $ summer 0 $ inc [1..100000] -- 24 MB, 87% productivity
    print $ sum $ scanl (+) 0 $ map (+1) [1..100000] -- 6 MB, 96% productivity

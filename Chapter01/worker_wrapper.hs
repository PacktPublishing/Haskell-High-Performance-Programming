
import System.Environment (getArgs)

isPrime :: Int -> Bool
isPrime n
    | n <= 1    = False
    | n <= 3    = True
    | otherwise = worker 2
       where
         worker i | i >= n       = True
                  | mod n i == 0 = False
                  | otherwise    = worker (i+1)

main = getArgs >>= putStrLn . show . isPrime . read . head

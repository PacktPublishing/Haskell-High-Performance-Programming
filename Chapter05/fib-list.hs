
import Control.Parallel

fib :: Int -> Int
fib n
    | n <= 1 = 1
    | otherwise = let a = fib (n - 1)
                      b = fib (n - 2)
                      in a + b

main = do
    let fibs = [ fib x | x <- [1..40] ] :: [Int]
    foldr par () fibs `seq` print fibs


import Control.Parallel.Strategies

fib :: Int -> Int
fib n
    | n <= 1 = 1
    | otherwise = let a = fib (n - 1)
                      b = fib (n - 2)
                      in a + b

main = do
    let res = runEval $ do
           x <- rpar $ fib 37
           y <- rpar $ fib 38
           z <- rpar $ fib 39
           w <- rpar $ fib 40
           return (x, y, z, w)
    res `seq` print res

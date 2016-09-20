-- file: backtracking-list.hs

import Control.Monad (guard)

special_pythagorean :: Int -> [(Int,Int,Int)]
special_pythagorean n = do
    a <- [1     .. n]
    b <- [a + 1 .. n]
    c <- [b + 1 .. n]
    guard (a + b + c == n)
    guard (a ^ 2 + b ^ 2 == c ^ 2)
    return (a, b, c)

main = print $ head $ special_pythagorean 1000

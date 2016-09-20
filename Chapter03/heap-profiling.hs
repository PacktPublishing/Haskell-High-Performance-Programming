-- file: heap-profiling.hs

sin' :: Double -> Double
sin' x = go 0 x where
  go n x
    | n > precision = x
    | otherwise     = go (n + 1) $ x +
        (-1) ** n * x ** (2 * n + 1) / factorial (2 * n + 1)

  precision = 800

  factorial n = product [1..n]

main = print $ sum $ map sin' [0,0.1..1]

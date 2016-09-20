module Main where

import Criterion.Main
import Data.List (foldl')

main = defaultMain [
    bgroup "list"
        [ bench "sum"    $ whnf sum            [1..1000000]
        , bench "foldr"  $ whnf (foldr (+) 0)  [1..1000000]
        , bench "foldl"  $ whnf (foldl (+) 0)  [1..1000000]
        , bench "foldl'" $ whnf (foldl' (+) 0) [1..1000000]
        ]
    ,
    bgroup "foldl"
        [ bench "_"  $ whnf (\_ -> foldl (+) 0 [1..1000000]) undefined
        , bench "()" $ whnf (\() -> foldl (+) 0 [1..1000000]) ()
        , bench "num"  $ whnf (\n -> foldl (+) 0 [1..n]) (1000000)
        , bench "num (strict)"  $ whnf (\n -> foldl' (+) 0 [1..n]) (1000000)
        ]
    ]

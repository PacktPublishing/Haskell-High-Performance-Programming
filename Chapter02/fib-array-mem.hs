-- file: fib-array-mem.hs
{-# LANGUAGE FlexibleContexts #-}

import Data.Array.IArray
import Data.Array.Unboxed (UArray)

fib :: Int -> Array Int Integer
fib n = arr where
  arr = listArray (1,n) $ 1 : 1 : [ arr!(i-2) + arr!(i-1) | i <- [3..n] ]

pascal :: Int -> Array (Int, Int) Integer
pascal n = arr where
  arr = array ((1,1),(n,n)) $
    [ ((i,1),1) | i <- [1..n] ] ++
    [ ((1,j),1) | j <- [1..n] ] ++
    [ ((i,j),arr!(i-1,j) + arr!(i,j-1)) | i <- [2..n], j <- [2..n] ]

main = do
    let arr = fib 100000
    print (arr!100000 `mod` 17)

toUArray :: (Ix i, IArray UArray e) => Array i e -> UArray i e
toUArray a = listArray (bounds a) (elems a)

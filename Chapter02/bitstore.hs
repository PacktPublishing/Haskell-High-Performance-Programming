-- file: bitstore.hs
{-# LANGUAGE BangPatterns #-}

import Data.Array.Unboxed
import Data.Bits (xor)

type BitTuple = (Bool, Bool, Bool)
data BitStruct = BitStruct !Bool !Bool !Bool deriving Show
type BitArray = UArray Int Bool

test :: Int -> Int -> Bool
test n x = x `mod` n == 0 

go :: BitStruct -> [Int] -> BitStruct
go res                       []     = res
go (BitStruct two three five) (x:xs) = go
    (BitStruct (test 2 x `xor` two) (test 3 x `xor` three) (test 5 x `xor` five)) xs

go' :: (Bool, Bool, Bool) -> [Int] -> (Bool, Bool, Bool)
go' res                   []     = res
go' (!two, !three, !five) (x:xs) = go'
    (test 2 x `xor` two, test 3 x `xor` three, test 5 x `xor` five) xs

goA :: BitArray -> [Int] -> BitArray
goA arr (x:xs) =
  let arr' = (listArray (0,2) [ test 2 x `xor` (arr!0)
                              , test 2 x `xor` (arr!1)
                              , test 2 x `xor` (arr!2) ])
      in arr' `seq` goA arr' xs
goA arr [] = arr
 

main =
    -- print $ go (BitStruct True True True)       [1..1000000] --  80 MB, 0.075s
    -- print $ go' (True, True, True)              [1..1000000] -- 176 MB, 0.1s
    print $ goA (listArray (0,2) (repeat True)) [1..1000000] -- 370 MB, 0.17s

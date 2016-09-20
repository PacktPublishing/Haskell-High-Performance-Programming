-- file: prof-basics.hs

sma :: [Double] -> [Double]
-- sma (x0:x1:xs) = (x0 + x1) / 2 : sma (x1:xs)
sma (x0:x1:xs) = let r = (x0 + x1) / 2 in r `seq` r : sma (x1:xs)
sma         xs = xs

main =
    -- let a = {-# SCC "list-" #-} [1..1000000]
    --     b = {-# SCC "sma-"  #-} sma a
    --     c = {-# SCC "sum-"  #-} sum b
    let a = [1..1000000]
        b = sma a
        c = sum b
    in print c

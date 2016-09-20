-- plain: 3.7s

import Control.Parallel.Strategies

minmax :: [Int] -> (Int, Int)
minmax xs = (minimum xs, maximum xs)

main = do
    let matrix = [ [1..1000001], [2..2000002], [3..2000003]
                 , [4..2000004], [5..2000005], [6..2000006]
                 , [7..2000007] ]
        minmaxes = map minmax matrix

     in print (minmaxes `using` parTraversable rdeepseq)

module MatrixSplice where

import Language.Haskell.TH.Quote

matrix :: QuasiQuoter
matrix = QuasiQuoter { quoteExp = dataToExpQ (\_ -> Nothing) . parse }

parse :: String -> [[Double]]
parse = map (map read . words) . filter (/= "") . lines

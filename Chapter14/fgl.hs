-- file: fgl.hs

import Data.Graph.Inductive.Graph
import Data.Graph.Inductive.PatriciaTree

build :: Int -> Gr Int ()
build 0 = empty
build n = (to, n, n, from) & build (n - 1) 
  where
    to   = []
    from = [ ((), m) | m <- [n - 1, n - 2 .. 0] ]

sumNodes :: [Int] -> Gr Int () -> Int
sumNodes []      _ = 0
sumNodes (n:ns) gr = case mctx of
    Nothing           -> sumNodes ns gr
    Just (_,_,x,from) -> x + sumNodes (ns ++ [ m | (_,m) <- from ]) gr'
  where
    (mctx, gr') = match n gr

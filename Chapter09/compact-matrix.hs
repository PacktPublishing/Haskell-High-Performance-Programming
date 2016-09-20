-- file compact-matrix.hs

{-# LANGUAGE QuasiQuotes #-}

import MatrixSplice

m1, m2 :: [[Double]]

m1 = [matrix|
  1 2
  2 1
|]

m2 = [matrix|
   1.5 4.2 5
   5.5 4.1 4
   4.5 4 1 6
|]

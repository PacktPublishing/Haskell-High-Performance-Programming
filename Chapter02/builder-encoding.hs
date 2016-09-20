-- file: builder-encoding.hs

-- Tree (1, Leaf "one") (2, Leaf "two")
-- into
-- [ 1:"one", 2:"two" ]

{-# LANGUAGE OverloadedStrings #-}

import Data.ByteString (ByteString)
import qualified Data.ByteString.Builder as B
import Data.Monoid ((<>))
import System.IO (stdout)

data Tree = Tree !(Int, Tree) !(Int, Tree)
          | Leaf !ByteString

encodeTree :: Tree -> B.Builder
encodeTree (Tree (l1, t1) (l2, t2)) = B.charUtf8 '['
    <> B.intDec l1 <> B.charUtf8 ':' <> encodeTree t1
    <> B.charUtf8 ','
    <> B.intDec l2 <> B.charUtf8 ':' <> encodeTree t2 <> B.charUtf8 ']'
encodeTree (Leaf bs) = B.charUtf8 '"' <> B.byteString bs <> B.charUtf8 '"'

main = B.hPutBuilder stdout $ encodeTree $
    Tree (1,Leaf "one") (2, Tree (3,Leaf "three") (4,Leaf "four"))

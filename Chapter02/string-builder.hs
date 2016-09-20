
type Builder = [Char] -> [Char]

toString :: Builder -> String
toString b = b []

string :: String -> Builder
string str = (str ++)

data Tree = Tree !(Int, Tree) !(Int, Tree)
          | Leaf !String

encodeTree :: Tree -> Builder
encodeTree (Tree (l1, t1) (l2, t2)) =
    string "[" . string (show l1) . string ":" . encodeTree t1 .
    string "," . string (show l2) . string ":" . encodeTree t2 . string "]"
encodeTree (Leaf str) = string "\"" . string str . string "\""

main = putStrLn $ toString $ encodeTree $
    Tree (1,Leaf "one") (2, Tree (3,Leaf "three") (4,Leaf "four"))

-- file: circular.hs
-- run with "./circular N", where N is the buffer size

import Data.Sequence as Seq
import Data.Foldable (toList, foldl')

import System.Environment

data Circular a = Circular !Int (Seq.Seq a)

create :: Int -> Circular a 
create n = Circular n Seq.empty

values :: Circular a -> [a]
values (Circular _ s) = toList s

observe :: Circular a -> a -> Circular a
observe (Circular n s) x
    | Seq.length s < n   = Circular n $ s  |> x
    | _ :< s' <- viewl s = Circular n $ s' |> x

main = do
    [x] <- getArgs
    print $ values $ foldl' observe (create (read x)) [1..10000000 :: Int]

-- file: dlist.hs

import Control.Monad.Writer

newtype DList a = DList ([a] -> [a])

fromList :: [a] -> DList a
fromList xs = DList (xs ++)

toList :: DList a -> [a]
toList (DList list) = list []

instance Monoid (DList a) where
    mempty = DList id
    mappend (DList x) (DList y) = DList (x . y)

-----------------------------------------------------

type DListWriter = Writer (DList Int)
type ListWriter  = Writer [Int]

action :: Int -> ListWriter ()
action 15000 = return ()
action n     = action (n + 1) >> tell [n]

action' :: Int -> DListWriter ()
action' 15000 = return ()
action' n     = action' (n + 1) >> tell (fromList [n])

main = do
    forM (snd $ runWriter (action 1)) print
    forM (toList $ snd $ runWriter (action' 1)) print

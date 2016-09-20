import Control.Parallel.Strategies

-- data A = A Int Bool [Double] String
-- 
-- buildPar :: A
-- buildPar = runEval $
--     Record <$> rpar toInt
--            <*> rpar toBool
--            <*> evalList rpar toList
--            <*> rpar toString

data T a b = T a b deriving (Show)

parT :: Strategy a -> Strategy b -> Strategy (T a b)
parT sa sb (T a b) = do
    a' <- rparWith sa a
    b' <- rparWith sb b
    return (T a' b')

parL :: Strategy a -> Strategy [a]
parL s xs = do
  go xs
  return xs
 where
  go [] = return ()
  go (x:xs) = do rpar `dot` s $ x
                 go xs

-- main = print (T (sum [1..1000000000 :: Int]) (sum [1..1000000001 :: Int]) `using` parT rdeepseq rdeepseq)
main = print ([sum [1..1000000000 :: Int], sum [1..1000000001 :: Int], sum [1..1000000002 :: Int], sum [1..1000000003 :: Int], sum [1..1000000004 :: Int], sum [1..1000000004 :: Int], sum [1..1000000004 :: Int]] `using` parL rdeepseq)

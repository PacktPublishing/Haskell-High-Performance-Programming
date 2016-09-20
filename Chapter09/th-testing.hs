
{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH
import ConstSplices
import Control.Monad (forM)


$(forM [1..15] constN)


idExp :: Q Exp
idExp = [| \x -> x |]

main = do
   putStrLn $ show $([| pi + 2 |])
   putStrLn $ $(constExp 2) "hello" () 42

-- const1 :: a -> b -> a
-- 
-- const2 :: a -> b -> c -> a
-- 
-- const3 :: a -> b -> c -> d -> a

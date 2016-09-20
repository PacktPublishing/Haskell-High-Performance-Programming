
{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH

n = 5

main = print $(fmap VarE (newName "n"))
   where n = 1

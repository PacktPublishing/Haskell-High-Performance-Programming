module ConstSplices where

import Language.Haskell.TH

constN :: Int -> Q Dec
constN nth = do
   exp <- constExp nth
   let name = mkName $ "const" ++ show nth
   return $ FunD name [ Clause [] (NormalB exp) [] ]

constExp :: Int -> Q Exp
constExp nth = do
   a <- newName "a"
   return $ LamE (VarP a : replicate nth WildP) (VarE a)


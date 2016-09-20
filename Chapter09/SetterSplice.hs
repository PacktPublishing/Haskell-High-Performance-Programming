module SetterSplice where

import Language.Haskell.TH
import Data.List (nub)
import Control.Monad (forM)

deriveSetters :: Name -> Q [Dec]
deriveSetters nm = do
   TyConI tyCon <- reify nm                             -- (1)
   case tyCon of
      DataD _ nm tyVars cs _ -> do                      -- (2)
         let fieldsTypes = nub (concatMap recFields cs) -- (3)
         forM fieldsTypes $
            \(nm, ty) -> setterDec nm                   -- (5)
  where
   recFields (RecC _ xs) =                              -- (4)
      map (\(var,_,ty) -> (var, ty)) xs

setterDec :: Name -> Q Dec
setterDec nm = do
   let nmD = mkName $ nameBase nm ++ "'"                      -- (2)
   nmV <- newName "val"
   nmP <- newName "p"
   let pat  = [VarP nmV, VarP nmP]                            -- (3)
       body = NormalB $ RecUpdE (VarE nmP) [ (nm, VarE nmV) ] -- (4)
   return $ FunD nmD [ Clause pat body [] ]                   -- (1)

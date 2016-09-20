-- file: reify-example.hs

{-# LANGUAGE TemplateHaskell #-}

import SetterSplice

data User = User
   { firstName :: String
   , lastName  :: String
   , age       :: Int
   } deriving Show

deriveSetters ''User

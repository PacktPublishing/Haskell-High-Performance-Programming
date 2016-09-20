-- file: gsum.hs

{-# LANGUAGE DefaultSignatures #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE TypeOperators #-}

{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE StandaloneDeriving #-}

import GHC.Generics

class GSum' f where
   gsum' :: f p -> Double

class GSum a where
   gsum :: a -> Double

   default gsum :: (Generic a, GSum' (Rep a)) => a -> Double
   gsum = gsum' . from

instance GSum Double where
   gsum = id

instance GSum Int where
   gsum = fromIntegral

instance GSum Integer where
   gsum = fromInteger

---------------------------------

instance GSum' V1 where
   gsum' _ = undefined

instance GSum' U1 where
   gsum' U1 = 1

instance (GSum' f, GSum' g) => GSum' (f :+: g) where
   gsum' (L1 x) = gsum' x
   gsum' (R1 y) = gsum' y

instance (GSum' f, GSum' g) => GSum' (f :*: g) where
   gsum' (x :*: y) = gsum' x + gsum' y

instance GSum c => GSum' (K1 i c) where
   gsum' (K1 x) = gsum x

instance GSum' f => GSum' (M1 i t f) where
   gsum' (M1 x) = gsum' x

----------------------------------

deriving instance (GSum a, GSum b) => GSum (Either a b)
deriving instance (GSum a, GSum b) => GSum (a, b)

data T a b = TA a | TB b | TAB a b
           deriving (Generic, GSum)

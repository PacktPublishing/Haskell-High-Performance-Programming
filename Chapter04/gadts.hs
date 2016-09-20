{-# LANGUAGE GADTs #-}

data Value a where
    Boolean :: Bool -> Value Bool
    Not     :: Value Bool -> Value Bool
    Numeric :: Num a => a -> Value a
    Sum     :: Num a => Value a -> Value a -> Value a

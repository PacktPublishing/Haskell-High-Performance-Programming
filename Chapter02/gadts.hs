-- file: gadts.hs
{-# LANGUAGE GADTs #-}

data Object a where
    Number :: Integral a => a -> Object a
    Number' :: Integral a => a -> Object a
    Character :: Char -> Object Char
    
data ObjectE where
    NumberE :: Integral a => a -> ObjectE

main = print $
    foldl (\a          b  -> a + b)              0 [ x         | x <- [1..1000000 :: Int] ]

    -- foldl (\a (Number b) -> a + b)              0 [ Number x  | x <- [1..1000000 :: Int] ]

    -- foldl (\a (NumberE b) -> a + fromIntegral b) 0 [ NumberE x | x <- [1..1000000 :: Int] ]

    -- foldl f 0 [ if odd x then Number x else Number' x  | x <- [1..1000000 :: Int] ]

    -- foldl f 0 [ Number x | x <- [1..1000000 :: Int] ]

f a x = case x of
            Character _ -> a
            Number n -> a + n
            Number' n -> a - n

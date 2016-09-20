-- file: strict_and_unpacked.hs
-- ghc -O

{-# LANGUAGE BangPatterns #-}

data PairP = PairP Int Int deriving (Show)

data PairS = PairS !Int !Int deriving (Show)

data PairU = PairU {-# UNPACK #-} !Int {-# UNPACK #-} !Int deriving (Show)

iter :: Int -> (a -> a) -> a -> a
iter end f x = go 0 x
    where go !n x | n < end   = go (n + 1) $! f x
                  | otherwise = x

main = print $ iter 10000
    (\(PairP !i !j) -> PairP (i*j) (i+j)) (PairP 1 1)            -- 373 KB
    -- (\(PairS !i !j) -> PairS (i*j) (i+j)) (PairS 1 1)            -- 53 KB
    -- (\(PairU !i !j) -> PairU (i*j) (i+j)) (PairU 1 1)            -- 53 KB

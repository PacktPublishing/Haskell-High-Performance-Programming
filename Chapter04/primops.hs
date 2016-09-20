-- file: primops.hs

{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}

import GHC.Exts
import GHC.Types (IO(IO))
import Control.Monad.Primitive

data CASArrayIO a = CASArrayIO (MutableArray# RealWorld a)

newCasArray :: Int -> a -> IO (CASArrayIO a)
newCasArray (I# n) a = IO $ \st0 ->
    let (# st1, arr #) = newArray# n a st0
        in (# st1, CASArrayIO arr #)

cas :: Ord a => CASArrayIO a -> Int -> a -> IO a
cas (CASArrayIO arr) (I# n) a = IO $ \st0 ->
    let (# st1, c #) = readArray# arr n st0
        a' = if a > c then a else c
        (# st2, r, b #) = casArray# arr n c a' st1
        in (# st2, b #)

cas' :: Ord a => CASArrayIO a -> Int -> a -> IO a
cas' (CASArrayIO arr) (I# n) a = do
    c <- primitive $ readArray# arr n
    let a' = if a > c then a else c
    primitive $ \st -> let (# st', _, b #) = casArray# arr n c a' st
                           in (# st', b #)
    

readCas :: CASArrayIO a -> Int -> IO a
readCas (CASArrayIO arr) (I# n) = IO $ readArray# arr n

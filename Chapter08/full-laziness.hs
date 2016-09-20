-- file: full-laziness.hs

import Control.Monad
import Control.Concurrent.MVar
import System.IO.Unsafe

unsafeVar :: a -> MVar a
unsafeVar i = unsafePerformIO (newMVar i)
{-# NOINLINE unsafeVar #-}

unsafeVar' :: b -> a -> MVar a
unsafeVar' _ i = unsafePerformIO (newMVar i)
{-# NOINLINE unsafeVar' #-}

main = do
    -- xs <- replicateM 10 (return (unsafeVar 1))
    -- xs <- forM [1..10] $ \_ -> return (unsafeVar 1)
    xs <- forM [1..10] $ \i -> return (unsafeVar' i 1)
    mapM_ takeMVar xs


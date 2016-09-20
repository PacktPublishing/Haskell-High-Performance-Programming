-- file: cse.hs

import Control.Monad
import Control.Concurrent.MVar
import System.IO.Unsafe

unsafeVar :: a -> MVar a
unsafeVar i = unsafePerformIO (newMVar i)
{-# NOINLINE unsafeVar #-}

main = do
    let a = unsafeVar 5
        b = unsafeVar 5
    takeMVar a
    takeMVar b

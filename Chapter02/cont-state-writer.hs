-- file: cont-state-writer.hs
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FlexibleContexts #-}

import Control.Monad.State.Strict
import Control.Monad.Cont

newtype StateCPS s r a = StateCPS (Cont (s -> r) a)
    deriving (Functor, Applicative, Monad, MonadCont)

instance MonadState s (StateCPS s r) where
    get   = StateCPS $ cont $ \k -> \s -> k s s
    put s = StateCPS $ cont $ \k -> \_ -> k () s

runStateCPS :: StateCPS s s () -> s -> s
runStateCPS (StateCPS m) = runCont m (\_ -> id)


-- TESTING

action :: MonadState Int m => m ()
action = replicateM_ 1000000 $ do
    i <- get
    put $! i + 1

main = do
    print $ (runStateCPS action 0 :: Int) -- 75ms, 224MB heap, 55KB GC
    print $ (snd $ runState action 0 :: Int)  -- 80ms, 312MB heap, 71KB GC

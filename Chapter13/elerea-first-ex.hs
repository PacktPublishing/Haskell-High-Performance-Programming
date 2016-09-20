-- file: elerea-first-ex.hs

{-# LANGUAGE RecursiveDo #-}

import Control.Monad
import Control.Applicative
import Control.Monad.IO.Class
import FRP.Elerea.Simple

sigtest :: Show a => SignalGen (Signal a) -> IO ()
sigtest gen = start gen >>= replicateM 10 >>= print

fibonacci :: SignalGen (Signal Int)
fibonacci = do
    rec fib  <- delay 1 fib1
        fib1 <- delay 1 fib2
        let fib2 = (+) <$> fib <*> fib1
    return fib

-- signaling side-effects

linesum :: SignalGen (Signal ())
linesum =
        fmap (fmap read) (effectful getLine)
    >>= transfer (0::Int) (+)
    >>= effectful1 (putStrLn . ("sum: " ++) . show)

memoizing :: SignalGen (Signal Int)
memoizing = do
    ln <- effectful getLine
    sums <- transfer (0::Int) (+)
    

-- dynamic countdowns

countdown :: Int -> SignalGen (Signal Int)
countdown n = stateful n (subtract 1)

-- Implementation taken from Elerea's haddocks
collection :: Signal [Signal a] -> (a -> Bool) -> SignalGen (Signal [a])
collection source isAlive = mdo
   sig <- delay [] (map snd <$> collWithVals')
   coll <- memo (liftA2 (++) source sig)
   let collWithVals = zip <$> (sequence =<< coll) <*> coll
   collWithVals' <- memo (filter (isAlive . fst) <$> collWithVals)
   return $ map fst <$> collWithVals'

readCountdowns :: SignalGen (Signal [Signal Int])
readCountdowns = do
    input <- effectful getLine
    generator $ do -- Signal (SignalGen [Signal Int])
        x <- input
        return $ case x of
            "" -> return []
            _  -> return <$> countdown (read x)

runCountdowns :: SignalGen (Signal [Int])
runCountdowns = do
    csig <- readCountdowns
    collection csig (> 0)

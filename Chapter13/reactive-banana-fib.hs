-- file: reactive-banana-fib.hs
{-# LANGUAGE RecursiveDo #-}

import Reactive.Banana

fib :: Event () -> Moment (Behavior Int)
fib step = mdo
    fib1 <- stepper 1 (fib2 <@ step)
    fib2 <- accumB 1 ((+) <$> fib1 <@ step)
    return fib1

-- file: yampa.hs

import FRP.Yampa

import Control.Monad (when)

square :: SF Double Double
square = arr (^2)

f :: SF Double Double
f  = arr (+1) >>> arr (^2)

cSum :: SF Int Int
cSum = loop (second (iPre 0) >>^ go)
    where go (x,s) = let s' = x + s in (s', s')

tick :: SF a Time
tick = time >>> loopPre 0 (arr (\(t, t') -> (t - t', t)))

switchFooBar, switchFooBar' :: SF () String
switchFooBar  = switch (constant "foo" &&& after 2 "bar") constant
switchFooBar' = dSwitch (constant "foo" &&& after 2 "bar") constant

switchRec :: SF () String
switchRec = go (0, "foo", "bar")
  where
    go (t, x, y) =
        switch (constant x &&& after (t + 2) (t + 2, y, x)) go

swap :: SF Bool String
swap = rSwitch foo <<< identity &&& swapEv
  where
    swapEv = edge >>> sscanPrim go True (Event foo)
    go tag = event Nothing $ \_ ->
        Just (not tag, Event $ if tag then bar else foo)

    foo = constant "foo"
    bar = constant "bar"

withCC :: SF Int Int
withCC = kSwitch (arr (+1)) trigger cont
    where
        trigger :: SF (Int, Int) (Event (Int -> Int))
        trigger = sscan f NoEvent

        f _ (inp,_) | inp > 1 && inp < 10 = Event (*inp)
                    | otherwise = NoEvent

        cont :: SF Int Int -> (Int -> Int) -> SF Int Int
        cont f f' = f >>> arr f'




main = reactimate init sense actuate sf
    where
        init = return "0"

        sense _ = do ln <- getLine
                     return (1, Just ln)

        actuate _ out = do putStrLn out
                           return (out == "END")

        sf = arr read >>>
             sscan (+) 0 >>>
             dSwitch (arr show &&& arr (filterE (>= 42) . Event)) (\_ -> constant "END")

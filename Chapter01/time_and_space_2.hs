-- ghc -O -rtsopts -XBangPatterns time_and_space_2.hs
-- time ./time_and_space_2 +RTS -s

goGen        u = sum [1..u] + product [1..u]
goGenShared  u = let xs = [1..u] in sum xs + product xs
goGenOnePass u = su + pu
  where
    (su, pu) = foldl f (0,1) [1..u]
    f (s, p) i = let s' = s+i
                     p' = p*i
                     in s' `seq` p' `seq` (s', p')
--    f (!s, !p) i = (s+i, p*i)

main = print $ do
	-- uncomment one of these lines, compile and execute

    -- goGen 10000             -- 0.050ms, 87MB heap,  10MB during GC,  0.7MB residency, 6MB total mem, 60% GC
    -- goGenShared 10000       -- 0.070ms, 88MB heap,  29MB during GC,  0.9MB residency, 7MB total mem, 70% GC
    -- goGenOnePass 10000      -- 0.025ms, 86MB heap, 0.9MB during GC, 0.05MB residency, 2MB total mem, 20% GC

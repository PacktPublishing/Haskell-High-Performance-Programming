import Control.Monad.Par

type A = Int
type B = Int
type C = Int
type D = Int

computation :: A -> (A -> B) -> (A -> C) -> (B -> C -> D) -> Par D
computation fa fb fc fd = do
    av <- newFull fa               -- (1)
    bv <- spawn $ do a <- get av   -- (2)
                     return $ fb a
    cv <- spawn $ do a <- get av   -- (3)
                     return $ fc a
    b <- get bv                    -- (4)
    c <- get cv
    return (fd b c)                -- (5)

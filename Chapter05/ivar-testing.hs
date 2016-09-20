
import Control.Monad.Par

f :: (NFData a, NFData b) => a -> b -> (a, b)
f c1 c2 = runPar $ do
    i1 <- new
    i2 <- new
    fork $ put i1 c1
    fork $ put i2 c2
    r1 <- get i1
    r2 <- get i2
    return (r1, r2)


main = print $
    runPar $ do
        iv <- new
        put iv (0 :: Int)
        put iv 1
        get iv
        

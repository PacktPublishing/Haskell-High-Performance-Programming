-- file: noise.hs

import ListT                      -- package list-t
import System.Random              -- package random
import Control.Monad.Trans (lift) -- package mtl
import Control.Concurrent (threadDelay)

noise :: [Double] -> ListT IO Double
noise pat = do
    pat'  <- ListT.repeat pat
    x     <- ListT.fromFoldable pat'
    lift $ do delay <- randomIO
              threadDelay (mod delay 300000)
              randomRIO (x - 0.5, x + 0.5)

main = let generator = noise [1,5,10,5]
           in ListT.traverse_ print generator >> print (E 0)

-- file: pipes.hs

import Control.Monad
import System.Random (randomIO)
import Pipes

randoms :: Producer' Int IO ()
randoms = forever (liftIO randomIO >>= yield)

taking :: Monad m => Int -> Pipe a a m ()
taking 0 = return ()
taking n = await >>= yield >> taking (n - 1)

printing :: Show a => Consumer' a IO ()
printing = forever (await >>= liftIO . print)

effect :: Effect IO ()
effect = randoms >-> taking 5 >-> printing

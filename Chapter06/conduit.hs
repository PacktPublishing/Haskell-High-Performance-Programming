-- file conduit.hs

import Control.Monad
import Control.Monad.IO.Class (liftIO)
import Data.Conduit
import System.Random (randomIO)

randoms :: Source IO Int
randoms = forever (liftIO randomIO >>= yield)

taking :: Monad m => Int -> Conduit a m a
taking 0 = error "ASdf" -- return ()
taking n = do x <- await
              case x of
                  Nothing -> return ()
                  Just y -> yield y >> taking (n - 1)

printing :: Show a => Sink a IO ()
printing = do x <- await
              case x of
                  Nothing -> return ()
                  Just y -> liftIO (print y) >> printing

main :: IO ()
main = randoms =$= taking 5 $$ printing

------------------------------------------

counter :: Source IO Int
counter = go 0
  where go n = yield n >> go (n + 1)



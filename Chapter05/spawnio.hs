
import Control.Monad.IO.Class
import Control.Monad.Par.IO
import Control.Monad.Par.Class

type A = Int
type B = Int
type C = Int
type D = Int

computationIO :: IO A -> (A -> IO B) -> (A -> IO C) -> (B -> C -> IO D) -> ParIO D
computationIO fa fb fc fd = do
    av <- newFull =<< liftIO fa
    bv <- spawn $ do a <- get av  
                     liftIO $ fb a
    cv <- spawn $ do a <- get av  
                     liftIO $ fc a
    b <- get bv                   
    c <- get cv
    liftIO (fd b c)               

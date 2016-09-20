
{-# LANGUAGE ExistentialQuantification #-}
import Control.Exception
import Data.Typeable

data MyException = MyException deriving (Show, Typeable)
instance Exception MyException

---------------------------------------------------------------------------

data SomeApplicationException = forall e. Exception e => SomeApplicationException e
                              deriving Typeable

instance Show SomeApplicationException where
    show (SomeApplicationException e) = "application: " ++ show e

instance Exception SomeApplicationException

-------------

data WorkerException = WorkerException String deriving (Show, Typeable)

instance Exception WorkerException where
    toException = toException . SomeApplicationException
    fromException x = do
        SomeApplicationException e <- fromException x
        cast e

---------------------------------------------------------------------------

foo = undefined

worker = throwIO $ WorkerException "flood"

main = do
    catch worker (\e@(WorkerException _) -> print e)
    catch worker (\e@(SomeApplicationException _) -> print e)

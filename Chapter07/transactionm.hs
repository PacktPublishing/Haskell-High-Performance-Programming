-- file: transactionm.hs

{-# LANGUAGE GeneralizedNewtypeDeriving #-}

import Control.Monad.Base
import Control.Monad.Trans.Reader
import Control.Concurrent.STM

import Control.Monad.Reader

type TransactionM a = ReaderT String STM a

newtype TransactionM' a = TransactionM' (ReaderT String STM a)
    deriving ( Functor, Applicative, Monad
             , MonadReader String, MonadBase STM )

transaction :: TVar a -> TransactionM' (Maybe a)
transaction var = do
    liftBase $ readTVar var
    return undefined

-- file: tvar-account.hs

import Control.Applicative
import Control.Concurrent.STM

type Balance = Int
type Account = TVar Balance

createAccount :: Balance -> STM Account
createAccount = newTVar

withdraw account amount = do
    balance <- readTVar account
    if balance - amount < 0
        then retry
        else writeTVar account $! balance - amount

deposit account amount = do
    balance <- readTVar account
    writeTVar account $! balance + amount

transfer from to n = do
    withdraw from n
    deposit to n

withdraw' :: Account -> Account -> Balance -> STM ()
withdraw' primary secondary amount =
    withdraw primary amount <|> withdraw secondary amount

main = do
    acc1 <- atomically $ createAccount 5
    acc2 <- atomically $ createAccount 3
    atomically $ transfer acc1 acc2 2
    atomically (readTVar acc1) >>= print
    atomically (readTVar acc2) >>= print

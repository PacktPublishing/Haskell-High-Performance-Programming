-- file: newtype-monadbasecontrol.hs
--
-- this doesn't compile as such and that's intentional

newtype Handler a = Handler
    { unHandler :: LoggingT (StateT HandlerState (ReaderT Config IO)) a }
    deriving ( ... )

instance MonadBaseControl IO Handler where
    type StM Handler a = StM (LoggingT (StateT HandlerState (ReaderT Config IO))) a
    liftBaseWith f     = Handler $ liftBaseWith $ \q -> f (q . unHandler)
    restoreM           = Handler . restoreM

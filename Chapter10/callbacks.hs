-- file: callbacks.hs

import Foreign.Ptr (FunPtr)

foreign import ccall safe -- (1)
   procedure :: FunPtr (Double -> IO ()) -> Double -> IO ()

foreign import ccall "wrapper" -- (2)
   toCallback :: (Double -> IO ()) -> IO (FunPtr (Double -> IO ()))

printRes :: Double -> IO () -- (3)
printRes x = putStrLn $ "Result: " ++ show x

main = do
   cont <- toCallback printRes -- (4)
   procedure cont 5 -- (5)
   procedure cont 8


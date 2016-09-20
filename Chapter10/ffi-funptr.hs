-- file: ffi-funptr.hs

import Foreign.Ptr (FunPtr)

foreign import ccall "math.h & cos"
   p_cos :: FunPtr (Double -> Double)

foreign import ccall "dynamic"
   mkF :: FunPtr (Double -> Double) -> (Double -> Double)

foreign import ccall "wrapper"
   toF :: (Double -> Double) -> IO (FunPtr (Double -> Double))


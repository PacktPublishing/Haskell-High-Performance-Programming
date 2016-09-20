-- file: ffi-c-var.hs

import Foreign.C (CInt)
import Foreign.Ptr (Ptr)
import Foreign.Storable (peek)

foreign import ccall unsafe "&" c_var :: Ptr CInt
foreign import ccall unsafe update :: IO ()

main = do peek c_var >>= print
          update
          peek c_var >>= print


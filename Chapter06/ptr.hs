
import System.IO
import Foreign.Ptr (Ptr)
import Foreign.Storable (Storable(sizeOf, peek))
import Foreign.Marshal (alloca)

main = withBinaryFile "/dev/random" ReadMode $ alloca . process
  where
    process :: Handle -> Ptr Int -> IO ()
    process h ptr = go where
      go = do
          count <- hGetBuf h ptr (sizeOf (undefined :: Int))
          if count > 0
              then do num <- peek ptr 
                      print num
                      go
              else return ()

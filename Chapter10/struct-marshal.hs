{-# LINE 1 "struct-marshal.hsc" #-}
-- file: struct-marshal.hsc
{-# LINE 2 "struct-marshal.hsc" #-}


{-# LINE 4 "struct-marshal.hsc" #-}

-- Define the #alignment macro for GHC 7. It is available by default
-- starting with GHC 8.0.1.

{-# LINE 8 "struct-marshal.hsc" #-}

import Foreign.Storable

data Some = Some { a :: Int, b :: Double }

instance Storable Some where
   sizeOf _ = ((16))
{-# LINE 15 "struct-marshal.hsc" #-}
   alignment _ = (8)
{-# LINE 16 "struct-marshal.hsc" #-}
   peek ptr = Some <$> ((\hsc_ptr -> peekByteOff hsc_ptr 0)) ptr
{-# LINE 17 "struct-marshal.hsc" #-}
                   <*> ((\hsc_ptr -> peekByteOff hsc_ptr 8)) ptr
{-# LINE 18 "struct-marshal.hsc" #-}
   poke ptr (Some a b) = do
      ((\hsc_ptr -> pokeByteOff hsc_ptr 0)) ptr a
{-# LINE 20 "struct-marshal.hsc" #-}
      ((\hsc_ptr -> pokeByteOff hsc_ptr 8)) ptr b
{-# LINE 21 "struct-marshal.hsc" #-}

main = undefined

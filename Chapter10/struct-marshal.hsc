-- file: struct-marshal.hsc

#include <struct-marshal-c.h>

import Foreign.Storable

data Some = Some { a :: Int, b :: Double }

-- Define the #alignment macro for GHC 7. It is available by default
-- starting with GHC 8.0.1.
#let alignment t = "%lu", (unsigned long)offsetof(struct {char x__; t (y__); }, y__)

instance Storable Some where
   sizeOf _ = (#size Some)
   alignment _ = (#alignment Some)
   peek ptr = Some <$> (#peek Some, a) ptr
                   <*> (#peek Some, b) ptr
   poke ptr some = do
      (#poke Some, a) ptr (a some)
      (#poke Some, b) ptr (b some)

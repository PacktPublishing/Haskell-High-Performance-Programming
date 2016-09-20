{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}

import qualified Data.Text as T
import qualified Data.ByteString as BS
import Data.Word (Word8)

-- class Index container index elem where
class Index container index elem | container -> elem where
    index :: container -> index -> elem

instance Index String Int Char where
    index = (!!)

instance Index T.Text Int Char where
    index = T.index

instance Index BS.ByteString Int Word8 where
    index = BS.index

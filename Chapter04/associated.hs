{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeFamilies #-}

import qualified Data.Text as T
import qualified Data.ByteString as BS
import Data.Word (Word8)

class Index container index where
    type Elem container
    index :: container -> index -> Elem container

instance Index String Int where
    type Elem String = Char
    index = (!!)

instance Index T.Text Int where
    type Elem T.Text = Char
    index = T.index

instance Index BS.ByteString Int where
    type Elem BS.ByteString = Word8
    index = BS.index

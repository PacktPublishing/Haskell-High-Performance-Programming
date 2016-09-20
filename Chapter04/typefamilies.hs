{-# LANGUAGE TypeFamilies #-}

import qualified Data.Text as T

type family Elem container
type instance Elem String = Char
type instance Elem T.Text = Char



type family Elem' container where
    Elem' String = Char
    Elem' T.Text = Char

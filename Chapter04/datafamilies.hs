{-# LANGUAGE TypeFamilies #-}

data family TStrict a

data instance TStrict (a, b) = TStrict2 !a !b
data instance TStrict (a, b, c) = TStrict3 !a !b !c

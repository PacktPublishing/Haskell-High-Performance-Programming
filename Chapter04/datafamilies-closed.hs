{-# LANGUAGE TypeFamilies #-}

data family TStrict a where
    TStrict (a, b) = TStrict2 !a !b
    TStrict (a, b, c) = TStrict3 !a !b !c


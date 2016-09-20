module A where

    import {-# SOURCE #-} B (b)

    a = "a"

    main = print b

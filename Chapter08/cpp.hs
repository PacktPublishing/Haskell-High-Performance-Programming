-- file: cpp.hs

{-# LANGUAGE CPP #-}

main = do
#ifdef DEVELOPMENT
    print "just debugging"
#endif
    return ()

{-# LANGUAGE ScopedTypeVariables #-}

fun :: forall a b. (a -> b) -> [a] -> [a] -> ([b], [b])
fun f xs ys = let go :: [a] -> [b]
                  go = map f
                  in (go xs, go ys)

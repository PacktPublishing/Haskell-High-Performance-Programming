{-# LANGUAGE PatternSynonyms #-}

pattern B1 a <- (a,_,_,_)
pattern B2 a <- (_,a,_,_)
pattern B3 a <- (_,_,a,_)
pattern B4 a <- (_,_,_,a)

fun (B1 True) = 1
fun (B2 True) = 2
fun (B3 True) = 3
fun (B4 True) = 4

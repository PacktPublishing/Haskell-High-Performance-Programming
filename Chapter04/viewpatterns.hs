{-# LANGUAGE ViewPatterns #-}

funky :: [Int] -> String
funky (length -> 0) = "Empty list!"
funky (last   -> 4) = "Ends in four!"
funky (sum    -> n) = "Sum is " ++ show n

-- funky xs | 0 <- length xs = "Empty list!"
--          | 4 <- last   xs = "Ends in four!"
--          | n <- sum    xs = "Sum is " ++ show n

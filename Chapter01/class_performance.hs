
class Some a where
    next :: a -> a -> a

instance Some Double where
    next a b = (a + b) / 2

goGeneral :: Some a => Int -> a -> a
goGeneral 0 x = x
goGeneral n x = goGeneral (n-1) (next x x)

goSpecialized :: Int -> Double -> Double
goSpecialized 0 x = x
goSpecialized n x = goSpecialized (n-1) (next' x x)

next' :: Double -> Double -> Double
next' a b = (a + b) / 2

main =
    -- 1.09GB allocation, 3.4s
    -- print $ (goGeneral (5000000 :: Int) 1.1 :: Double)

    -- 1.01GB allocation, 3.2s 
    print $ (goSpecialized (5000000 :: Int) 1.1 :: Double)

-- time_and_space.hs
import Data.List (foldl')

sum' :: Fractional a => [a] -> a
sum' = foldl' (+) 0

mean :: Fractional a => [a] -> a
mean v = sum' v / fromIntegral (length v)

covariance :: [Double] -> [Double] -> Double
covariance xs ys =
    sum' (zipWith (\x y -> (x - mean xs) * (y - mean ys)) xs ys)
    / fromIntegral (length xs)

main = do
    let xs = [1, 1.1 .. 500]
        ys = [2, 2.1 .. 501]
    print $ covariance xs ys

covariance' :: [Double] -> [Double] -> Double
covariance' xs ys =
    let mean_xs = mean xs
        mean_ys = mean ys
        in
    sum' (zipWith (\x y -> (x - mean_xs) * (y - mean_ys)) xs ys)
    / fromIntegral (length xs)

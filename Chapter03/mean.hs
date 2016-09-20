-- file: mean.hs

mean xs = sum xs / fromIntegral (length xs)

sumlg xs = sum (map log xs)

main = do
    print $ mean [1..1000000]
    print $ sumlg [1..1000001]

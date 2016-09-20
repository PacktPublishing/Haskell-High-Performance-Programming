-- file: lazypat.hs

server :: [Int] -> [Int]
server (y:ys) = process y : server ys
  where process n = n ^ 2

client :: Int -> [Int] -> [Int]
client initial ~(x:xs) = initial : client (next x) xs
  where next n = n `mod` 65534

requests :: [Int]
requests = client initial responses
    where initial = 2

responses :: [Int]
responses = server requests

main =
    print $ take 10 responses


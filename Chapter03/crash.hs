-- file: crash.hs

f = head
g = f . tail
h = g . tail

main = print $ h [1,2]

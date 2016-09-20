-- file: ffi-fib.hs

foreign import ccall
   fib_c :: Int -> Int

main = print $ fib_c 20

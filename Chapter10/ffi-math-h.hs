-- file: ffi-math-h.hs

foreign import ccall unsafe "math.h sin"
   csin :: Double -> Double

main = print (csin pi)

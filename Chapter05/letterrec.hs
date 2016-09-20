-- file: letterrec.hs
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE BangPatterns #-}

import Data.Array.Repa as Repa
import Data.Array.Repa.IO.BMP as BMP
import Data.Array.Repa.Algorithms.Pixel as Pixel
import Data.Array.Repa.Algorithms.Convolve as Conv
import Data.Array.Repa.Unsafe as Unsafe
import Data.List (foldl1')

type Image r = Array r DIM2 Double

readImage :: FilePath -> IO (Image U)
readImage !fp = do
    result <- BMP.readImageFromBMP fp
    computeP $ mirror $ case result of
        Left err -> error "readImage: Failed to load image from file"
        Right array -> Repa.map Pixel.doubleLuminanceOfRGB8 array

mirror :: Image D -> Image D
mirror !img = Unsafe.unsafeBackpermute (extent img) (\(Z :. x :. y) -> ix2 (mx - 1 - x) y) img
  where Z :. mx :. _ = extent img

sta, stb, stc :: Image U

sta = fromListUnboxed (ix2 8 5)
    [ -1, -1, -1, -1, -1
    , -1, -1, -1, -1, -1
    , -1,  1,  1,  1, -1
    , -1, -1, -1, -1,  1
    , -1,  1,  1,  1,  1
    ,  1, -1, -1, -1,  1
    ,  1, -1, -1, -1,  1
    , -1,  1,  1,  1,  1 ]

stb = fromListUnboxed (ix2 8 5)
    [  1, -1, -1, -1, -1
    ,  1, -1, -1, -1, -1
    ,  1,  1,  1,  1, -1
    ,  1, -1, -1, -1,  1
    ,  1, -1, -1, -1,  1
    ,  1, -1, -1, -1,  1
    ,  1, -1, -1, -1,  1
    ,  1,  1,  1,  1, -1 ]

stc = fromListUnboxed (ix2 8 5)
    [ -1, -1, -1, -1, -1
    , -1, -1, -1, -1, -1
    , -1,  1,  1,  1, -1
    ,  1, -1, -1, -1,  1
    ,  1, -1, -1, -1, -1
    ,  1, -1, -1, -1, -1
    ,  1, -1, -1, -1,  1
    , -1,  1,  1,  1, -1 ]

std :: Image U
std = computeUnboxedS . transpose . mirror $ transpose stb

{-# INLINE sta #-}
{-# INLINE stb #-}
{-# INLINE stc #-}
{-# INLINE std #-}

{-# INLINE match #-}

{-# INLINE recognize #-}

{-# INLINE readImage #-}

{-# INLINE mirror #-}

match :: Monad m => Char -> Image U -> Image U -> m (Array D DIM2 Char)
match !char !stencil !image = do
    let !threshold = sumAllS (Repa.map (max 0) stencil) - 0.1
    res <- convolveP (const 0) stencil image
    return $! Repa.map (\(!x) -> if x > threshold then char else '\NUL') res

recognize :: Monad m => Image U -> m String
recognize !img = do
    let !recs = [ match c st img
                | (c, st) <- [ ('a', sta), ('b', stb), ('c', stc), ('d', std) ] ]
    letters <- sequence recs
    combined <- computeUnboxedP $ foldl1' (Repa.zipWith max) letters
    let !(Z :. _ :. my) = extent combined
        !lineEnds = Unsafe.unsafeTraverse combined id $ \f ix@(Z :. _ :. y) ->
             if y == my - 1 then '\n' else f ix
    return $! unlines . words $ filter (/= '\NUL') $ toList lineEnds
    
main = do
    img <- readImage "image.bmp"
    str <- recognize img
    putStr str

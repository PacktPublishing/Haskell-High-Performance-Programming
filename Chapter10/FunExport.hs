module FunExport where

foreign export ccall
   fun :: Int -> Int -> Int

fun :: Int -> Int -> Int
fun a b = a ^ 2 + b

module Main where

lem x = x || not x
{-# INLINE lem #-}
{-# RULES "lem/tautology" forall a. lem a = True #-}

main = print $ lem True

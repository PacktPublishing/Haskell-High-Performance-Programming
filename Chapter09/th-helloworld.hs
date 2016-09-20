-- file: th-helloworld.hs
{-# LANGUAGE TemplateHaskell #-}

import Language.Haskell.TH

main = putStrLn $(return (LitE (StringL "Hello World!")))

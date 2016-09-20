-- file: ekg-fact.hs
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad
import System.Remote.Monitoring -- package ekg
import System.Metrics -- package ekg-core
import qualified System.Metrics.Counter as Counter -- package ekg-core

main = do
    server <- forkServer "localhost" 8000
    factorials <- createCounter "factorials.count" (serverMetricStore server)
    forever $ do
        input <- getLine
        print $ product [1..read input :: Integer]
        Counter.inc factorials

{-
-- file: ekg-fact.hs
{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad
import System.Remote.Monitoring

main = do
    forkServer "localhost" 8000
    forever $ do
        input <- getLine
        print $ product [1..read input :: Integer]
-}

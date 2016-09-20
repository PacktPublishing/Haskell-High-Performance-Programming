-- file: reactive-banana-counter.hs
{-# LANGUAGE ScopedTypeVariables #-}

import Graphics.UI.WX
import Reactive.Banana
import Reactive.Banana.WX

app :: IO ()
app = do
    f    <- frame [ text := "App" ]
    up   <- button f [ text := "Up" ]
    down <- button f [ text := "Down" ]
    res  <- staticText f [] 

    set f [ layout := margin 10
            ( column 5 [ widget res
                       , row 5 [widget up, widget down] ] ) ]

    let 
        network :: MomentIO ()
        network = do
            eup <- event0 up command
            edown <- event0 down command

            (counter :: Behavior Int)
                <- accumB 0 $ unions
                    [ (+1) <$ eup
                    , subtract 1 <$ edown
                    ]

            sink res [ text :== show <$> counter ]

    evnet <- compile network
    actuate evnet

main = start app

import Data.Char (toUpper)
import System.IO

main = do
    hSetBuffering stdin LineBuffering
    hSetBuffering stdout LineBuffering
    interact (map toUpper)

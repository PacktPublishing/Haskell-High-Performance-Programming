-- file: io-streams-exceptions.hs

import           Control.Exception
import           System.IO.Streams (Generator, InputStream, OutputStream)
import qualified System.IO.Streams as S

divideBy :: InputStream Int -> InputStream Int -> IO (InputStream Int)
divideBy as bs = S.makeInputStream go
  where
    go = do
        ma <- S.read as
        mb <- S.read bs
        case (ma, mb) of
            (Just a, Just b) ->
                (return $! Just $! div a b)
                `catch`
                (const go :: ArithException -> IO (Maybe Int))
            _ -> return Nothing

thisFails :: IO (InputStream Int)
thisFails = S.makeInputStream (return (Just undefined))

thisFailsCorrectly :: IO (InputStream Int)
thisFailsCorrectly = S.makeInputStream (return $! Just $! undefined)

main = do x <- S.fromList [0..4]
          y <- S.fromList [1,0,0,2]
          divideBy x y >>= S.toList >>= print

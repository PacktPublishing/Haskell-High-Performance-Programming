-- file: io-streams-parser.hs
{-# LANGUAGE OverloadedStrings #-}

import Data.Monoid ((<>))
import           Control.Applicative ((<|>))
import           Data.ByteString (ByteString)
import           Data.Attoparsec.ByteString.Char8 as PC8
import           System.IO.Streams (Generator, InputStream, OutputStream)
import qualified System.IO.Streams as S

import System.IO.Streams.File (withFileAsInput)
import System.IO.Streams.Attoparsec (parserToInputStream)

data Line = Notification ByteString | Message Time User ByteString deriving Show
type Time = ByteString
type User = ByteString

{- Input format

[00:50] <Seneca> It is the power of the mind to be unconquerable
[05:03] <Leibniz> The monad here is nothing but a simple substance which enters into compounds
[00:01] <Erin> Warriors should suffer their pain silently

 -}

timeParser :: Parser Time
timeParser = char '[' *> takeWhile1 (/= ']') <* char ']' <* PC8.takeWhile (== ' ')

userParser :: Parser User
userParser = char '<' *> takeWhile1 (/= '>') <* char '>' <* PC8.takeWhile (== ' ')

lineParser, messageParser, notificationParser :: Parser Line

lineParser         = messageParser <|> notificationParser

notificationParser = string "=== " *> (Notification <$> PC8.takeWhile (/= '\n'))

messageParser      = Message <$> timeParser <*> userParser <*> PC8.takeWhile (/= '\n')

--------------------------------------------

logParser :: Parser (Maybe Line)
logParser = (endOfInput *> pure Nothing) <|>
    (fmap Just lineParser <* PC8.takeWhile (== '\n'))

lineOutputStream :: IO (OutputStream Line)
lineOutputStream = S.contramapMaybe f =<< S.ignoreEof S.stdout
  where
    f (Message _ _ msg) = Just (msg <> "\n")
    f _                 = Nothing

main = withFileAsInput "messages.log" $ \is -> do
    lines <- parserToInputStream logParser is
    outs <- lineOutputStream
    S.connect lines outs

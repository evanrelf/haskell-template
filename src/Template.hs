module Template
  ( Options (..)
  , parseOptions
  , main
  )
where

import Options.Applicative qualified as Options

data Options = Options {}

parseOptions :: Options.Parser Options
parseOptions = do
  pure Options{}

main :: Options -> IO ()
main _options = putTextLn "Hello world!"

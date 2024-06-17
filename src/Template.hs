module Template (main) where

import Options.Applicative qualified as Options

data Options = Options {}

parseOptions :: Options.Parser Options
parseOptions = do
  pure Options{}

getOptions :: IO Options
getOptions = do
  let parserPrefs = Options.prefs mempty
  let parserInfo =
        Options.info (Options.helper <*> parseOptions) mempty
  Options.customExecParser parserPrefs parserInfo

main :: IO ()
main = do
  _options <- getOptions
  putTextLn "Hello world!"

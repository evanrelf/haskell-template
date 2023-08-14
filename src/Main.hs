{-# LANGUAGE ApplicativeDo #-}

module Main (main) where

import Options.Applicative qualified as Options
import Template qualified

getOptions :: IO Template.Options
getOptions = do
  let parserPrefs = Options.prefs mempty
  let parserInfo =
        Options.info (Options.helper <*> Template.parseOptions) mempty
  Options.customExecParser parserPrefs parserInfo

main :: IO ()
main = do
  options <- getOptions
  Template.main options

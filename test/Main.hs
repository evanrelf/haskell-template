module Main (main) where

import qualified Test.Hspec as Hspec


main :: IO ()
main = Hspec.hspec do
  Hspec.it "works" do
    Hspec.pending

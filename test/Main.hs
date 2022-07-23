module Main (main) where

import Test.Tasty.HUnit ((@?=))

import qualified Test.Tasty as Tasty
import qualified Test.Tasty.HUnit as HUnit

main :: IO ()
main = Tasty.defaultMain do
  Tasty.testGroup "Examples" $
    [ HUnit.testCase "Example test" $
        ['a', 'b', 'c'] `compare` ['a' .. 'z'] @?= LT
    ]

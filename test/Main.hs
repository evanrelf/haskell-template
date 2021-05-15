module Main (main) where

import Test.Tasty.HUnit ((@?=))

import Test.Tasty qualified as Tasty
import Test.Tasty.HUnit qualified as HUnit


main :: IO ()
main = Tasty.defaultMain do
  Tasty.testGroup "Examples" $
    [ HUnit.testCase "Example test" $
        ['a', 'b', 'c'] `compare` ['a' .. 'z'] @?= LT
    ]

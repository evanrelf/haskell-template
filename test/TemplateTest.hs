{-# OPTIONS_GHC -Wno-unused-imports #-}

module TemplateTest (module TemplateTest) where

import Hedgehog
import Prelude hiding (bool)
import Test.Tasty.HUnit

import Hedgehog.Gen qualified as Gen
import Hedgehog.Range qualified as Range

hprop_or :: Property
hprop_or = property do
  bool <- forAll Gen.bool
  (bool || True) === True
  (True || bool) === True

unit_true :: Assertion
unit_true = do
  True @?= True

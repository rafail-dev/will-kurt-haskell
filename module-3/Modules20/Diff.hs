module Modules20.Diff where

import Modules20.TS (Data, TS (TS), TimeIndex)

diffPair :: (Num a) => Maybe a -> Maybe a -> Maybe a
diffPair Nothing _ = Nothing
diffPair _ Nothing = Nothing
diffPair (Just v1) (Just v2) = Just $ v1 - v2

diffTS :: (Num a) => TS a -> TS a
diffTS (TS [] []) = TS [] []
diffTS (TS times values) = TS times $ Nothing : diffs
  where
    diffs = zipWith diffPair (tail values) values
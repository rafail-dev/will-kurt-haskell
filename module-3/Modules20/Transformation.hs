module Modules20.Transformation where

import Modules20.TS (Data, TS (TS), TimeIndex)

type TransformationFunction a b = (a -> a -> Maybe b)

diffPair :: (Num a) => TransformationFunction a a
-- diffPair = (Just .) . subtract
diffPair v1 v2 = Just $ v2 - v1

ratioPair :: (Eq a, Real a) => TransformationFunction a Double
ratioPair v1 v2
  | v2 == 0 = Nothing
  | otherwise = Just $ realToFrac v1 / realToFrac v2

transformTS :: (Num a, Num b) => TransformationFunction a b -> TS a -> TS b
transformTS _ (TS [] []) = TS [] []
transformTS f (TS times values) = TS times $ Nothing : relations
  where
    f' Nothing _ = Nothing
    f' _ Nothing = Nothing
    f' (Just v1) (Just v2) = f v1 v2
    relations = zipWith f' (tail values) values
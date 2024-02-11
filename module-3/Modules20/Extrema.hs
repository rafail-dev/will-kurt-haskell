module Modules20.Extrema where

import Modules20.TS (Data, TS (TS), TimeIndex)

type CompareFunction a = a -> a -> a

type ComparePairFunction a = (TimeIndex, Maybe a) -> (TimeIndex, Maybe a) -> (TimeIndex, Maybe a)

comparePair :: (Eq a) => CompareFunction a -> ComparePairFunction a
comparePair _ (i1, Nothing) (_, Nothing) = (i1, Nothing)
comparePair _ (_, Nothing) (i2, value2) = (i2, value2)
comparePair _ (i1, value1) (_, Nothing) = (i1, value1)
comparePair compareFunction (i1, Just value1) (i2, Just value2)
  | compareFunction value1 value2 == value1 = (i1, Just value1)
  | otherwise = (i2, Just value2)

compareTS :: (Eq a) => CompareFunction a -> TS a -> Maybe (TimeIndex, Maybe a)
compareTS _ (TS [] []) = Nothing
compareTS compareFunction (TS times values)
  | all (== Nothing) values = Nothing
  | otherwise = Just best
  where
    best = foldr (comparePair compareFunction) (0, Nothing) $ zip times values

minTS :: (Ord a) => TS a -> Maybe (TimeIndex, Maybe a)
minTS = compareTS min

maxTS :: (Ord a) => TS a -> Maybe (TimeIndex, Maybe a)
maxTS = compareTS max
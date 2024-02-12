module Modules20.CentralTendency (median, mean, centralTendencyTS, StatisticalFunction) where

import Data.List (sort)
import Data.Maybe (catMaybes)
import Modules20.TS (TS (TS), TimeIndex)

type StatisticalFunction a b = ([a] -> Maybe b)

median :: (Real a) => StatisticalFunction a Double
median [] = Nothing
median xs = Just $ realToFrac doubleMedian / 2
  where
    sorted = sort xs
    firstCenter = length xs `div` 2
    center
      | odd $ length xs = [firstCenter, firstCenter]
      | otherwise = [firstCenter, firstCenter - 1]
    doubleMedian = sum (map (sorted !!) center)

mean :: (Real a) => StatisticalFunction a Double
mean [] = Nothing
mean xs = Just $ total / count
  where
    total = realToFrac . sum $ xs
    count = realToFrac . length $ xs

centralTendencyTS :: (Real a, Real b) => StatisticalFunction a b -> TS a -> Maybe b
centralTendencyTS _ (TS _ []) = Nothing
centralTendencyTS f (TS _ values)
  -- agenda
  | all (== Nothing) values = Nothing
  | otherwise = f $ catMaybes values
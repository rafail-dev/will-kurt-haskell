module Modules20.Median where

import Data.List (sort)
import Data.Maybe (catMaybes)
import Modules20.TS (TS (TS))

medianTS :: (Real a) => TS a -> Maybe Double
medianTS (TS _ []) = Nothing
medianTS (TS _ values)
  | all (== Nothing) values = Nothing
  | otherwise = Just $ median $ catMaybes values
  where
    median :: (Real a) => [a] -> Double
    median xs = realToFrac doubleMedian / 2
      where
        sorted = sort xs
        firstCenter = length xs `div` 2
        center
          | odd $ length xs = [firstCenter, firstCenter]
          | otherwise = [firstCenter, firstCenter - 1]
        doubleMedian = sum (map (sorted !!) center)
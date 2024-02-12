module Modules20.Moving where

import Data.Maybe (fromJust)
import Modules20.CentralTendency (StatisticalFunction)
import Modules20.TS (TS (TS))

type Window = Int

moving :: (Real a, Real b) => StatisticalFunction a b -> [Maybe a] -> Window -> [Maybe b]
moving _ [] _ = []
moving f values n
  | length valuesForF == n = result : moving f restValues n
  | otherwise = []
  where
    valuesForF = take n values
    restValues = tail values
    result
      -- agenda
      | Nothing `elem` valuesForF = Nothing
      | otherwise = f $ map fromJust valuesForF

movingTS :: (Real a, Real b) => StatisticalFunction a b -> Window -> TS a -> TS b
movingTS _ _ (TS [] []) = TS [] []
movingTS f n (TS times values) = TS times smoothedValues
  where
    nothings = replicate (n `div` 2) Nothing
    normalized = moving f values n
    smoothedValues = mconcat [nothings, moving f values n, nothings]
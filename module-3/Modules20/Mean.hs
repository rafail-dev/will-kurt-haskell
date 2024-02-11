module Modules20.Mean where

import Data.Maybe (catMaybes, fromJust)
import Modules20.TS (TS (TS))

mean :: (Real a) => [a] -> Double
mean xs = total / count
  where
    total = realToFrac . sum $ xs
    count = realToFrac . length $ xs

meanTS :: (Real a) => TS a -> Maybe Double
meanTS (TS _ []) = Nothing
meanTS (TS _ values)
  | all (== Nothing) values = Nothing
  | otherwise = Just $ mean $ catMaybes values

meanMaybe :: (Real a) => [Maybe a] -> Maybe Double
meanMaybe values
  | Nothing `elem` values = Nothing
  | otherwise = Just $ mean $ map fromJust values

movingAvg :: (Real a) => [Maybe a] -> Int -> [Maybe Double]
movingAvg [] _ = []
movingAvg values n
  | length nextValues == n = meanMaybe nextValues : movingAvg restValues n
  | otherwise = []
  where
    nextValues = take n values
    restValues = tail values

movingAvgTS :: (Real a) => TS a -> Int -> TS Double
movingAvgTS (TS [] []) _ = TS [] []
movingAvgTS (TS times values) n = TS times smoothedValues
  where
    nothings = replicate (n `div` 2) Nothing
    smoothedValues = mconcat [nothings, movingAvg values n, nothings]
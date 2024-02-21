module Modules20.StandartDeviation where

import Data.Maybe (catMaybes)
import Modules20.CentralTendency (mean)
import Modules20.TS (TS (TS))

differencesOfSquares :: (Real a, Real b) => [a] -> b -> Maybe [Double]
differencesOfSquares values mean = Just $ map f values
  where
    f = (^ 2) . (realToFrac mean -) . realToFrac

variance :: (Real a) => [a] -> Maybe Double
variance values = maybeDifferencesOfSquares >>= mean
  where
    maybeMean = mean values
    -- >>= - bind
    maybeDifferencesOfSquares = maybeMean >>= differencesOfSquares values

-- standard deviation for the population
-- standartDeviation [2, 4, 4, 4, 5, 5, 7, 9] (Wiki)
standartDeviation :: (Real a) => [a] -> Maybe Double
-- fmap / <$> insted of custom sqrtMaybe
standartDeviation values = sqrt <$> variance values

standartDeviationTS :: (Real a) => TS a -> Maybe Double
standartDeviationTS (TS _ values) = standartDeviation $ catMaybes values
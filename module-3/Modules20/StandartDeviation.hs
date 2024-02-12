module Modules20.StandartDeviation where

import Data.Maybe (catMaybes)
import Modules20.CentralTendency (centralTendencyTS, mean)
import Modules20.TS (TS (TS))
import Modules20.Transformation (diffPair, transformTS)

-- diffsSquare :: (Real a, Real b) => [a] -> Maybe b -> Maybe [Double]
-- diffsSquare _ Nothing = Nothing
-- diffsSquare values (Just mean) = Just $ map f values
--   where
--     f = (^ 2) . (realToFrac mean -) . realToFrac

diffsSquare' :: (Real a, Real b) => [a] -> b -> Maybe [Double]
diffsSquare' values mean = Just $ map f values
  where
    f = (^ 2) . (realToFrac mean -) . realToFrac

standartDeviation :: (Real a) => TS a -> Maybe Double
standartDeviation (TS [] []) = Nothing
-- fmap insted of sqrtMaybe
standartDeviation (TS _ values) = sqrt <$> maybeDiffsSquareMean
  where
    clearValues = catMaybes values
    maybeMean = mean clearValues
    -- maybeDiffsSquare = diffsSquare clearValues maybeMean
    -- >>= - bind
    maybeDiffsSquare = maybeMean >>= diffsSquare' clearValues
    maybeDiffsSquareMean = maybeDiffsSquare >>= mean
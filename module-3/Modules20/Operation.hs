module Modules20.Operation where

import Data.Map qualified as Map
import Data.Maybe (isJust, mapMaybe)
import Modules20.TS (TS (TS))

filterJust :: [(k, Maybe a)] -> [(k, a)]
filterJust = mapMaybe extract
  where
    extract (k, Just v) = Just (k, v)
    extract (_, Nothing) = Nothing

operate :: (Real a) => (a -> a -> a) -> Maybe a -> Maybe a -> Maybe a
operate _ Nothing _ = Nothing
operate f (Just v1) Nothing = Just v1
operate f (Just v1) (Just v2) = Just $ f v1 v2

operateTS :: (Real a) => (a -> a -> a) -> TS a -> TS a -> TS a
operateTS _ ts1 (TS [] []) = ts1
operateTS _ (TS [] []) ts2 = TS [] []
operateTS f (TS t1 v1) (TS t2 v2) = TS t1 newValues
  where
    ts1Tuples = zip t1 v1
    ts2Map = Map.fromList $ filterJust $ zip t2 v2
    newValues = map (\(t, v) -> operate f v (Map.lookup t ts2Map)) ts1Tuples
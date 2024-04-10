module Modules20.TS where
-- cabal install --lib containers
import Data.Map qualified as Map
import Data.Maybe (isJust, mapMaybe)

type TimeIndex = Int

type Data = Double

data TS a = TS [TimeIndex] [Maybe a]

-- ==

instance (Show a) => Show (TS a) where
  show :: (Show a) => TS a -> String
  show (TS times values) = mconcat $ zipWith showPair times values

showPair :: (Show a, Show b) => a -> Maybe b -> String
showPair time (Just value) = mconcat [show time, "|", show value, "\n"]
showPair time Nothing = mconcat [show time, "|NA\n"]

-- ==

instance Semigroup (TS a) where
  (<>) :: TS a -> TS a -> TS a
  (<>) = combineTS

insertMaybePair :: (Ord k) => (k, Maybe v) -> Map.Map k v -> Map.Map k v
-- insertMaybePair (_, Nothing) map = map
insertMaybePair (_, Nothing) = id
insertMaybePair (time, Just v) = Map.insert time v

combineTS :: TS a -> TS a -> TS a
combineTS ts1 (TS [] []) = ts1
combineTS (TS [] []) ts2 = ts2
combineTS (TS t1 v1) (TS t2 v2) = TS completeTimes completeValues
  where
    bothTimes = mconcat [t1, t2]
    completeTimes = [minimum bothTimes .. maximum bothTimes]
    timeValueMap = foldr insertMaybePair Map.empty $ zip t1 v1 ++ zip t2 v2
    completeValues = map (`Map.lookup` timeValueMap) completeTimes

-- ==

instance Monoid (TS a) where
  mempty :: TS a
  mempty = TS [] []
  mappend :: TS a -> TS a -> TS a
  mappend = (<>)

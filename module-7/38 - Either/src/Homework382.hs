module Homework382 (succ', tail', last') where

succ' :: (Bounded a, Enum a, Eq a) => a -> Maybe a
succ' v
  | v == maxBound = Nothing
  -- \| otherwise = Just $ succ 1
  | otherwise = Just $ toEnum (fromEnum v + 1)

tail' :: [a] -> [a]
tail' [] = []
tail' (_ : xs) = xs

last' :: Int -> [a] -> Either String a
last' _ [] = Left "Empty"
-- last' maxLength v
--   | maxLength < length v = Left "Unbound"
--   | otherwise = Right $ last v
last' maxLength v = f' maxLength v
  where
    f' :: Int -> [a] -> Either String a
    f' _ [] = Left "Empty"
    f' 0 _ = Left "Unbound"
    f' _ [v'] = Right v'
    f' maxLength' (_ : vs') = f' (maxLength' - 1) vs'

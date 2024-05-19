module Homework381 (addStrInts) where

import Text.Read (readMaybe)

addStrInts :: String -> String -> Either String Int
addStrInts a b = case (readMaybe a, readMaybe b) of
  (Nothing, Nothing) -> Left "Both inputs are invalid Ints"
  (Nothing, _) -> Left "The first input is an Int"
  (_, Nothing) -> Left "The second input is an Int"
  (Just x, Just y) -> Right (x + y)

module Nested (f) where

f1 :: Bool -> Either String Bool
f1 True = Right True
f1 False = Left "Error"

f2 :: Bool -> Either String Bool
f2 True = Right True
f2 False = Left "Error"

f3 :: Bool -> Either Int Bool
f3 True = Right True
f3 False = Left 1

f :: Bool -> Either String (Either Int Bool)
f v = f3 <$> (f1 v >>= f2)

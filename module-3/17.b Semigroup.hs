{-# OPTIONS_GHC -Wall #-}

data Color = Red | Yellow | Blue | Green | Purple | Orange | Brown deriving (Show, Eq)

instance Semigroup Color where
  (<>) :: Color -> Color -> Color
  (<>) Red Blue = Purple
  (<>) Blue Blue = Purple
  (<>) Yellow Blue = Green
  (<>) Blue Yellow = Green
  (<>) Yellow Red = Orange
  (<>) Red Yellow = Orange
  (<>) a b
    | a == b = a
    | all (`elem` [Red, Blue, Purple]) [a, b] = Purple
    | all (`elem` [Blue, Yellow, Green]) [a, b] = Green
    | all (`elem` [Red, Yellow, Orange]) [a, b] = Orange
    | otherwise = Brown

-- (Green <> Blue) <> Yellow == Green
-- Green <> (Blue <> Yellow) == Green
-- Green <> Blue <> Yellow == Green

-- Associativity formally required of the Semigroup type class
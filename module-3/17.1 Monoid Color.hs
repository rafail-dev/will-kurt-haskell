{-# OPTIONS_GHC -Wall #-}

{-
class (Semigroup a) => Monoid a where
  idendity :: a

class Monoid a where
  mempty :: a
  mapped :: a -> a -> a
  mconat :: [a] -> [a]

-}

{-
Rules

mappend mempty x = x
mappend x mempty = x
mappend x (mappend y z) = mappend (mappend  x y) z
mconcat = foldr mappend mempty
-}

data Color = Red | Yellow | Blue | Green | Purple | Orange | Brown | Transparent deriving (Show, Eq)

instance Semigroup Color where
  (<>) :: Color -> Color -> Color
  (<>) Transparent b = b
  (<>) a Transparent = a
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

instance Monoid Color where
  mempty = Transparent
  mappend = (<>)

{-
but also but more difficult
"19.b isJust & isNothings.hs" emptyDrawerCount

-}
import Data.Maybe (isJust, isNothing)

data Organ = Heart | Brain | Kidney | Spleen deriving (Show, Eq)

{-
"Let's assume there are only 3 drawers, and the availability list has already been formed."
-}
firstPartion :: [Maybe Organ]
firstPartion = [Just Heart, Just Spleen, Nothing]

secondPartion :: [Maybe Organ]
secondPartion = [Nothing, Nothing, Just Spleen]

emptyDrawers :: [Maybe Organ] -> Int
emptyDrawers = length . filter isNothing

main :: IO ()
main = do
  print $ emptyDrawers firstPartion
  print $ emptyDrawers secondPartion
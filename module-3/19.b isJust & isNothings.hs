import Data.List (intercalate)
import Data.Map qualified as Map
import Data.Maybe (isJust, isNothing)

data Organ = Heart | Brain | Kidney | Spleen deriving (Show, Eq)

organCatalog :: Map.Map Int Organ
organCatalog = Map.fromList $ zip [3, 5, 6, 2, 49] [Heart, Heart, Brain, Spleen, Spleen]

possibleDrawers :: [Int]
possibleDrawers = [1 .. 50]

-- drawerContents = flip (map . flip Map.lookup)
drawerContents :: [Int] -> Map.Map Int Organ -> [Maybe Organ]
drawerContents ids catalog = map (`Map.lookup` catalog) ids

availableOrgans :: [Maybe Organ]
availableOrgans = drawerContents possibleDrawers organCatalog

-- ==

isSomething :: Maybe Organ -> Bool
isSomething Nothing = False
isSomething (Just _) = True

-- justTheOrgans = filter isJust availableOrgans
justTheOrgans :: [Maybe Organ]
justTheOrgans = filter isSomething availableOrgans

-- emptyDrawerCount availableOrgans = length $ filter isNothing (drawerContents possibleDrawers availableOrgans)
emptyDrawerCount :: Map.Map Int Organ -> Int
emptyDrawerCount = length . filter isNothing . drawerContents possibleDrawers

showOrgan :: Maybe Organ -> String
showOrgan (Just organ) = show organ
showOrgan Nothing = ""

-- ==
format :: String -> String -> String
format a b = mconcat [a, "\n", show b, "\n\n"]

main :: IO ()
main = do
  putStrLn $ format "Just the organs" $ intercalate ", " $ map showOrgan justTheOrgans
  putStrLn $ format "EmptyDrawerCount" $ show $ emptyDrawerCount organCatalog

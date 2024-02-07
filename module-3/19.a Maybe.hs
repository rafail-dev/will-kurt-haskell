{-
data Maybe a = Nothing | Just a
-}
import Data.Map qualified as Map

data Organ = Heart | Brain | Kidney | Spleen deriving (Show, Eq)

organs :: [Organ]
organs = [Heart, Heart, Brain, Spleen, Spleen, Kidney]

ids :: [Int]
ids = [2, 7, 13, 14, 21, 24]

organPairs :: [(Int, Organ)]
organPairs = zip ids organs

organCatalog :: Map.Map Int Organ
organCatalog = Map.fromList organPairs

possibleDrawers :: [Int]
possibleDrawers = [1 .. 50]

-- drawerContents = flip (map . flip Map.lookup)
drawerContents :: [Int] -> Map.Map Int Organ -> [Maybe Organ]
drawerContents ids catalog = map (`Map.lookup` catalog) ids

availableOrgans :: [Maybe Organ]
availableOrgans = drawerContents possibleDrawers organCatalog

-- countOrgan = (length .) . filter . (==) . Just
countOrgan :: Organ -> [Maybe Organ] -> Int
countOrgan organ available = length (filter (\x -> x == Just organ) available)


main :: IO ()
main = do
  print $ countOrgan Spleen availableOrgans

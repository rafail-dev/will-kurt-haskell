import Data.List (intercalate)
import Data.Map qualified as Map
import Data.Maybe (isJust, isNothing)

data Organ = Heart | Brain | Kidney | Spleen deriving (Show)

organCatalog :: Map.Map Int Organ
organCatalog = Map.fromList $ zip [3, 5, 6, 2, 49] [Heart, Heart, Brain, Spleen, Spleen]

data Container = Vat Organ | Cooler Organ | Bag Organ

instance Show Container where
  show :: Container -> String
  show (Vat organ) = show organ ++ " in a vat"
  show (Cooler organ) = show organ ++ " in a cooler"
  show (Bag organ) = show organ ++ " in a bag"

data Location = Lab | Kitchen | Bathroom deriving (Show)

organToContainer :: Organ -> Container
organToContainer Brain = Vat Brain
organToContainer Heart = Cooler Heart
organToContainer another = Bag another

placeInLocation :: Container -> (Location, Container)
placeInLocation (Vat a) = (Lab, Vat a)
placeInLocation (Cooler a) = (Lab, Cooler a)
placeInLocation (Bag a) = (Kitchen, Vat a)

-- ==

process :: Organ -> (Location, Container)
process organ = placeInLocation (organToContainer organ)

report :: (Location, Container) -> String
report (location, container) =
  show container
    ++ " in the "
    ++ show location

-- ==

processAndReport :: Maybe Organ -> String
processAndReport (Just organ) = report $ process organ
processAndReport Nothing = "error, id not found"

processRequest :: Int -> Map.Map Int Organ -> String
processRequest id catalog = processAndReport $ Map.lookup id catalog

main :: IO ()
main = do
  -- "Heart in a cooler in the Lab"
  print $ processRequest 3 organCatalog

  -- "error, id not found"
  print $ processRequest 10 organCatalog

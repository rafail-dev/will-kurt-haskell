import Data.Map qualified as Map

data Organ = Heart | Brain | Kidney | Spleen deriving (Show, Eq, Ord, Enum, Bounded)

type Count = Int

type OrganCount = Map.Map Organ Count

organs :: [Organ]
organs = [Heart, Heart, Brain, Spleen, Spleen]

inventory :: OrganCount
inventory = foldr (Map.adjust (+ 1)) initial organs
  where
    initial = Map.fromList $ map (,0) [minBound .. maxBound]

main :: IO ()
main = do
  print $ Map.toList inventory
  print $ mconcat [show Kidney, ": ", show $ Map.lookup Kidney inventory]
  print $ mconcat [show Heart, ": ", show $ Map.lookup Heart inventory]

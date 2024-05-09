minOfList :: (Ord a) => [a] -> Maybe a
minOfList [] = Nothing
minOfList (f : rest) = Just $ foldr min f rest

--

meAndMyNeighbor :: Int
meAndMyNeighbor = 2

exists :: [Int]
exists = [6, 12]

drank :: [Int]
drank = [2 * meAndMyNeighbor]

guests :: [Int]
guests = [2, 3]

eachWillDrink :: [Int]
eachWillDrink = [3, 4]

count :: Int -> Int -> Int -> Int -> Int
count exists drank guests eachWillDrink =
  exists - drank - (meAndMyNeighbor + guests) * eachWillDrink

variants :: [Int]
variants = pure count <*> exists <*> drank <*> guests <*> eachWillDrink

main :: IO ()
main = do
  print $ abs . (min 0) <$> minOfList variants

import Data.Array
import Data.Map qualified as Map
import Data.Maybe (catMaybes, fromJust, isJust)
import Data.Semigroup ()

type TimeIndex = Int

type Data = Double

data TS a = TS [TimeIndex] [Maybe a]

instance (Show a) => Show (TS a) where
  show :: (Show a) => TS a -> String
  show (TS times values) = mconcat $ zipWith showPair times values

showPair :: (Show a, Show b) => a -> Maybe b -> String
showPair time (Just value) = mconcat [show time, "|", show value, "\n"]
showPair time Nothing = mconcat [show time, "|NA\n"]

-- ==

file1 :: [(TimeIndex, Data)]
file1 =
  [ (1, 200.1),
    (2, 199.5),
    (3, 199.4),
    (4, 198.9),
    (5, 199.0),
    (6, 200.2),
    (9, 200.3),
    (10, 201.2),
    (12, 202.9)
  ]

file2 :: [(TimeIndex, Data)]
file2 =
  [ (11, 201.6),
    (12, 201.5),
    (13, 201.5),
    (14, 203.5),
    (15, 204.9),
    (16, 207.1),
    (18, 210.5),
    (20, 208.8)
  ]

file3 :: [(TimeIndex, Data)]
file3 =
  [ (10, 201.2),
    (11, 201.6),
    (12, 201.5),
    (13, 201.5),
    (14, 203.5),
    (17, 210.5),
    (24, 215.1),
    (25, 218.7)
  ]

file4 :: [(TimeIndex, Data)]
file4 =
  [ (26, 219.8),
    (27, 220.5),
    (28, 223.8),
    (29, 222.8),
    (30, 223.8),
    (31, 221.7),
    (32, 222.3),
    (33, 220.8),
    (34, 219.4),
    (35, 220.1),
    (36, 220.6)
  ]

fileToTS :: [(TimeIndex, a)] -> TS a
fileToTS pairs = createTS times values
  where
    (times, values) = unzip pairs

createTS :: [TimeIndex] -> [a] -> TS a
createTS times values = TS completeTimes extendedValues
  where
    completeTimes = [minimum times .. maximum times]
    timeValuesMap = Map.fromList $ zip times values
    extendedValues = map (`Map.lookup` timeValuesMap) completeTimes

-- ==

instance Semigroup (TS a) where
  (<>) :: TS a -> TS a -> TS a
  (<>) = combineTS

insertMaybePair :: (Ord k) => (k, Maybe v) -> Map.Map k v -> Map.Map k v
-- insertMaybePair (_, Nothing) map = map
insertMaybePair (_, Nothing) = id
insertMaybePair (time, Just v) = Map.insert time v

combineTS :: TS a -> TS a -> TS a
combineTS ts1 (TS [] []) = ts1
combineTS (TS [] []) ts2 = ts2
combineTS (TS t1 v1) (TS t2 v2) = TS completeTimes completeValues
  where
    bothTimes = mconcat [t1, t2]
    completeTimes = [minimum bothTimes .. maximum bothTimes]
    timeValueMap = foldr insertMaybePair Map.empty $ zip t1 v1 ++ zip t2 v2
    completeValues = map (`Map.lookup` timeValueMap) completeTimes

{-
fileToTS file1 <> fileToTS file2
-}

-- ==

instance Monoid (TS a) where
  mempty :: TS a
  mempty = TS [] []
  mappend :: TS a -> TS a -> TS a
  mappend = (<>)

{-
mconcat $ map fileToTS [file1, file2, file3, file4]
-}

-- ==

mean :: (Real a) => [a] -> Double
mean xs = total / count
  where
    total = (realToFrac . sum) xs
    count = realToFrac (length xs)

meanTS :: (Real a) => TS a -> Maybe Double
meanTS (TS _ []) = Nothing
meanTS (TS _ values)
  | all (== Nothing) values = Nothing
  | otherwise = Just $ mean $ catMaybes values

-- ==

type CompareFunction a = a -> a -> a

type ComparePairFunction a = (TimeIndex, Maybe a) -> (TimeIndex, Maybe a) -> (TimeIndex, Maybe a)

comparePair :: (Eq a) => CompareFunction a -> ComparePairFunction a
comparePair _ (i1, Nothing) (_, Nothing) = (i1, Nothing)
comparePair _ (_, Nothing) (i2, value2) = (i2, value2)
comparePair _ (i1, value1) (_, Nothing) = (i1, value1)
comparePair compareFunction (i1, Just value1) (i2, Just value2)
  | compareFunction value1 value2 == value1 = (i1, Just value1)
  | otherwise = (i2, Just value2)

compareTS :: (Eq a) => CompareFunction a -> TS a -> Maybe (TimeIndex, Maybe a)
compareTS _ (TS [] []) = Nothing
compareTS compareFunction (TS times values)
  | all (== Nothing) values = Nothing
  | otherwise = Just best
  where
    best = foldr (comparePair compareFunction) (0, Nothing) $ zip times values

-- ==

diffPair :: (Num a) => Maybe a -> Maybe a -> Maybe a
diffPair Nothing _ = Nothing
diffPair _ Nothing = Nothing
diffPair (Just v1) (Just v2) = Just $ v1 - v2

diffTS :: (Num a) => TS a -> TS a
diffTS (TS [] []) = TS [] []
diffTS (TS times values) = TS times $ Nothing : diffs
  where
    diffs = zipWith diffPair (tail values) values

-- ==

meanMaybe :: (Real a) => [Maybe a] -> Maybe Double
meanMaybe values
  | Nothing `elem` values = Nothing
  | otherwise = Just $ mean $ map fromJust values

movingAvg :: (Real a) => [Maybe a] -> Int -> [Maybe Double]
movingAvg [] _ = []
movingAvg values n
  | length nextValues == n = meanMaybe nextValues : movingAvg restValues n
  | otherwise = []
  where
    nextValues = take n values
    restValues = tail values

movingAvgTS :: (Real a) => TS a -> Int -> TS Double
movingAvgTS (TS [] []) _ = TS [] []
movingAvgTS (TS times values) n = TS times smoothedValues
  where
    nothings = replicate (n `div` 2) Nothing
    smoothedValues = mconcat [nothings, movingAvg values n, nothings]

-- ==

main :: IO ()
main = do
  let tsAll = mconcat $ map fileToTS [file1, file2, file3, file4]
  print "All"
  print tsAll
  putStrLn ""

  print "Mean"
  print $ meanTS tsAll
  putStrLn ""

  print "Min"
  print $ compareTS min tsAll
  putStrLn ""

  print "Max"
  print $ compareTS max tsAll
  putStrLn ""

  putStrLn "Mean Delta"
  print $ meanTS $ diffTS tsAll
  putStrLn ""

  putStrLn "3-point moving Avg"
  print $ movingAvgTS tsAll 3
  putStrLn ""
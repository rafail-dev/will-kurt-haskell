import Data.Array
import Data.List (sort)
import Data.Map qualified as Map
import Data.Maybe (catMaybes, fromJust, isJust)
import Modules20.Data (file1, file2, file3, file4)
import Modules20.Diff (diffTS)
import Modules20.Extrema (maxTS, minTS)
import Modules20.Mean (meanTS, movingAvgTS)
import Modules20.Median (medianTS)
import Modules20.TS (Data, TS (TS), TimeIndex)

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
  print $ minTS tsAll
  putStrLn ""

  print "Max"
  print $ maxTS tsAll
  putStrLn ""

  putStrLn "Mean Delta"
  print $ meanTS $ diffTS tsAll
  putStrLn ""

  putStrLn "3-point moving Avg"
  print $ movingAvgTS tsAll 3
  putStrLn ""

  putStrLn "Median"
  print $ medianTS tsAll
  putStrLn ""

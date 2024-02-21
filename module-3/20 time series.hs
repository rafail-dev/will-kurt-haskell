import Data.Array
import Data.List (sort)
import Data.Map qualified as Map
import Data.Maybe (catMaybes, fromJust, isJust)
import Modules20.CentralTendency (centralTendencyTS, mean, median)
import Modules20.Data (file1, file2, file3, file4)
import Modules20.Extremum (extremumTS)
import Modules20.Moving (movingTS)
import Modules20.TS (Data, TS (TS), TimeIndex)
import Modules20.Transformation (diffPair, ratioPair, transformTS)
import Modules20.StandartDeviation (standartDeviationTS)

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

tsAll :: TS Data
tsAll = mconcat $ map fileToTS [file1, file2, file3, file4]

main :: IO ()
main = do
  print "All"
  print tsAll
  putStrLn ""

  print "Min"
  print $ extremumTS min tsAll
  putStrLn ""

  print "Max"
  print $ extremumTS max tsAll
  putStrLn ""

  print "Mean"
  print $ centralTendencyTS mean tsAll
  putStrLn ""

  print "Median"
  print $ centralTendencyTS median tsAll
  putStrLn ""

  print "Diffs"
  print $ transformTS diffPair tsAll
  putStrLn ""

  print "Rations"
  print $ transformTS ratioPair tsAll
  putStrLn ""

  putStrLn "Mean Delta"
  -- print $ meanTS $ diffTS tsAll
  print $ centralTendencyTS mean $ transformTS diffPair tsAll
  putStrLn ""

  putStrLn "Mean Ratio"
  -- print $ meanTS $ diffTS tsAll
  print $ centralTendencyTS mean $ transformTS ratioPair tsAll
  putStrLn ""

  putStrLn "3-point Moving Mean"
  print $ movingTS mean 3 tsAll
  putStrLn ""

  putStrLn "3-point Moving Median"
  print $ movingTS median 3 tsAll
  putStrLn ""

  putStrLn "Standart Deviation"
  print $ standartDeviationTS tsAll
  putStrLn ""
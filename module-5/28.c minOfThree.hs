minOfThree :: (Ord a) => a -> a -> a -> a
minOfThree v1 v2 v3 = min v1 (min v2 v3)

readInt :: IO Int
readInt = read <$> getLine

minOfIOInts :: IO Int
minOfIOInts = minOfThree <$> readInt <*> readInt <*> readInt

main :: IO ()
main = do
  print "Input 3 ints"
  result <- minOfIOInts
  print $ "Min: " ++ show result
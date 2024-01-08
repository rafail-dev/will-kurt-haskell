myInFirstHals x list = x `elem` half
  where
    half = take halfIndex list
    n = length list
    incrementer = if even n then 0 else 1
    halfIndex = n `div` 2 + incrementer

collatzStepCount 1 = 1
collatzStepCount n =
  if even n
    then 1 + collatzStepCount (n `div` 2)
    else 1 + collatzStepCount (n * 3 + 1)

collatzList 1 = [1]
collatzList 2 = [2, 1]
collatzList 3 = [3, 10, 5, 16, 8, 4, 2, 1]
collatzList n
  | even n = n : collatzList (n `div` 2)
  | otherwise = n : collatzList (n * 3 + 1)

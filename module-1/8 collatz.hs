collatzStepCount 1 = 1
collatzStepCount n =
  if even n
    then 1 + collatzStepCount (n `div` 2)
    else 1 + collatzStepCount (n * 3 + 1)

collatzList 1 = [1]
collatzList 2 = [2, 1]
collatzList 3 = [3, 10, 5, 16, 8, 4, 2, 1]
collatzList n = generate n []
  where
    generate 1 list = list ++ [1]
    generate n list = generate nextN (list ++ [n])
      where
        nextN =
          if even n
            then n `div` 2
            else n * 3 + 1

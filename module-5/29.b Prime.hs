primes :: Int -> [Int]
primes n = filter (not . (`elem` composite)) [2 .. n]
  where
    composite = pure (*) <*> [2 .. n] <*> [2 .. n]
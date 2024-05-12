powersOfTwo :: Int -> [Int]
powersOfTwo n = do
  value <- [1 .. n]
  return (2 ^ value)

powersOfTwoMap :: Int -> [Int]
powersOfTwoMap n = map (2 ^) [1 .. n]

--

allEvenOdds :: Int -> [(Int, Int)]
allEvenOdds n = do
  evenValue <- [2, 4 .. n]
  oddValue <- [1, 3 .. n]
  pure (evenValue, oddValue)

allEvenOdds' :: Int -> [(Int, Int)]
allEvenOdds' n = do
  liftA2 (,) [2, 4 .. n] [2, 4 .. n]

powersOfTwo :: Int -> [Int]
powersOfTwo n = do
  value <- [1 .. n]
  return (2 ^ value)

powersOfTwo' :: Int -> [Int]
powersOfTwo' n = [2 ^ value | value <- [1 .. n]]

powerOfTwoAndThree :: Int -> [(Int, Int)]
powerOfTwoAndThree n =
  [ (powerOfTwo, powersOfThree)
    | value <- [1 .. n],
      let powerOfTwo = 2 ^ value,
      let powersOfThree = 3 ^ value
  ]

powerOfTwoAndThree' :: Int -> [(Int, Int)]
powerOfTwoAndThree' n = [(2 ^ v, 3 ^ v) | v <- [1 .. n]]

--

evenGuard :: Int -> [Int]
evenGuard n = [v | v <- [1 .. n], even v]
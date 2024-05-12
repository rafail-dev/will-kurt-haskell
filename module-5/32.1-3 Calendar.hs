maxDaysInMonths :: [Int]
maxDaysInMonths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

calendar :: [Int]
calendar =
  [ date
    | max <- maxDaysInMonths,
      date <- [1 .. max]
  ]

calendar' :: [Int]
calendar' = do
  max <- maxDaysInMonths
  [1 .. max]

calendar'' :: [Int]
calendar'' = maxDaysInMonths >>= (\max -> [1 .. max])
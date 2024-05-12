type Price = Double

type Diameter = Double

type Area = Double

data Pizza = Pizza Diameter Price deriving (Eq)

-- area diameter = pi * (diameter / 2) ^ 2
area :: Diameter -> Area
area = (pi *) . (^ 2) . (/ 2)

-- pricePer diameter price = area diameter / price
pricePer :: Diameter -> Price -> Price
pricePer = (/) . area

instance Ord Pizza where
  compare :: Pizza -> Pizza -> Ordering
  compare (Pizza diameter1 price1) (Pizza diameter2 price2) = compare pricePer1 pricePer2
    where
      pricePer1 = pricePer diameter1 price1
      pricePer2 = pricePer diameter2 price2

--

readDouble :: IO Double
readDouble = read <$> getLine

main :: IO ()
main =
  putStrLn "What is the diameter of Pizza 1?"
    >> readDouble
    >>= ( \diameter1 ->
            putStrLn "What is the price of Pizza 1?"
              >> readDouble
              >>= ( \price1 ->
                      putStrLn "What is the diameter of Pizza 2?"
                        >> readDouble
                        >>= ( \diameter2 ->
                                putStrLn "What is the price of Pizza 2?"
                                  >> readDouble
                                  >>= ( \price2 ->
                                          ( \pizza1 pizza2 ->
                                              case compare pizza1 pizza2 of
                                                EQ -> putStrLn "Same"
                                                GT -> putStrLn "Winner - Pizza 1"
                                                LT -> putStrLn "Winner - Pizza 2"
                                          )
                                            (Pizza diameter1 price1)
                                            (Pizza diameter2 price2)
                                      )
                            )
                  )
        )
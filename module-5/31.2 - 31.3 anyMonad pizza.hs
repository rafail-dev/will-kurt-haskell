import Data.Map qualified as Map

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

prices :: [Price]
prices = [150, 200]

diameters :: [Diameter]
diameters = [30, 50]

readDouble :: IO Double
readDouble = read <$> getLine

stringMain :: [String]
stringMain = do
  diameter1 <- diameters
  price1 <- prices
  diameter2 <- diameters
  price2 <- prices

  let pizza1 = Pizza diameter1 price1
  let pizza2 = Pizza diameter2 price2

  case compare pizza1 pizza2 of
    EQ -> pure "Same"
    GT -> pure "Winner - Pizza 1"
    LT -> pure "Winner - Pizza 2"

anyMonadMain ::
  (Monad m) =>
  m Diameter ->
  m Price ->
  m Diameter ->
  m Price ->
  m String
anyMonadMain diameter1 price1 diameter2 price2 = do
  pizza1 <- liftA2 Pizza diameter1 price1
  pizza2 <- liftA2 Pizza diameter2 price2

  case compare pizza1 pizza2 of
    EQ -> pure "Same"
    GT -> pure "Winner - Pizza 1"
    LT -> pure "Winner - Pizza 2"
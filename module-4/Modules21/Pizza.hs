module Modules21.Pizza
  ( Pizza (..),
    area,
    pricePer,
    Price,
    Area,
    Diameter,
  )
where

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
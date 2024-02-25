module Lesson21d where

import Data.Map qualified as Map
import Modules21.Pizza (Diameter, Price)

prices :: Map.Map Word Price
prices = Map.fromList [(1, 150), (2, 220)]

diameters :: Map.Map Word Diameter
diameters = Map.fromList [(1, 30), (2, 50)]

maybeMain :: Maybe String
maybeMain = do
  diameter1 <- Map.lookup 1 diameters
  price1 <- Map.lookup 1 prices

  diameter2 <- Map.lookup 2 diameters
  price2 <- Map.lookup 2 prices

  let pizza1 = (diameter1, price1)
  let pizza2 = (diameter2, price2)

  case compare pizza1 pizza2 of
    EQ -> return "Same"
    GT -> return "Winner - Pizza 1"
    LT -> return "Winner - Pizza 2"
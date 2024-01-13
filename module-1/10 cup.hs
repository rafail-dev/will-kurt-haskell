{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore cupConstructor "Redundant lambda" #-}

cupConstructor ml = \message -> message ml

--

getMl cup = cup id

-- same
-- getMl cup = cup (\ml -> ml)

isEmpty cup = getMl cup == 0

drink cup mlDrank = cupConstructor (max diff 0)
  where
    diff = getMl cup - mlDrank

--

coffeeCup = cupConstructor 350

coffeeCupAfterSip = drink coffeeCup 100

coffeeCupAfterManySips = foldl drink coffeeCup [25, 25, 25, 25]
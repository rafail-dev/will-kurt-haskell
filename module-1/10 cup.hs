-- cupConstructor ml = \message -> message ml
cupConstructor ml message = message ml

--

-- getMl cup = cup (\ml -> ml)
getMl cup = cup id

isEmpty cup = getMl cup == 0

drink cup mlDrank = cupConstructor (max diff 0)
  where
    diff = getMl cup - mlDrank

--

coffeeCup = cupConstructor 350

coffeeCupAfterSip = drink coffeeCup 100

coffeeCupAfterManySips = foldl drink coffeeCup [25, 25, 25, 25]
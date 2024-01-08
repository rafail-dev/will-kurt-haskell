myGCD2 a 0 = a
myGCD2 a b = myGCD2 b (a `mod` b)

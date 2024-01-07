{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore counter1 counter2 "Avoid lambda using `infix`" #-}

counter1 :: Num a => a -> a
counter1 x = (\x -> x + 1) ((\x -> x + 1) (x + 1))

counter2 x = (+ 1) ((\x -> x + 1) (x + 1))

counter3 x = (+ 1) ((+ 1) (x + 1))
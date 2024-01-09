{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore incrementAll myMap "Use map" #-}
increment = (+ 1)

incrementAll [] = []
incrementAll (x : xs) = x + 1 : incrementAll xs

myMap f [] = []
myMap f (x : xs) = f x : myMap f xs

-- myMap (\x -> x + 1) [1 .. 10]
-- myMap increment [1 .. 10]

result = map increment [1 .. 10]
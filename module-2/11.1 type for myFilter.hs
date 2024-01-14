{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore myFilter3 "Eta reduce" #-}

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f = foldr step []
  where
    step x = (++) ([x | f x])

{-
["value" | True] = ["value"]
["value" | False] = []
-}

-- same
myFilter2 :: (a -> Bool) -> [a] -> [a]
myFilter2 f = foldr step []
  where
    step x l = ([x | f x]) ++ l

-- same
myFilter3 :: (a -> Bool) -> [a] -> [a]
myFilter3 f l = foldr step [] l
  where
    step x l = ([x | f x]) ++ l
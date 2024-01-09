{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore myFilter myRemove  "Use foldr" #-}

myFilter f [] = []
myFilter f (x : xs) = [x | f x] ++ myFilter f xs

myFilter2 f [] = []
myFilter2 f (x : xs) =
  if f x
    then x : myFilter2 f xs
    else myFilter2 f xs

myRemove f [] = []
myRemove f (x : xs) = [x | not (f x)] ++ myRemove f xs

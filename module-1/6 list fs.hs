{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore l7 "Use infix" #-}

-- https://hackage.haskell.org/package/base/docs/Data-List.html

l1 = [1, 2, 3] !! 1 -- 2

l2 = (!!) [1, 2, 3] 1 -- 2

l3 = ("hello" !!)

l3' = l3 1 -- e

l4 = (!! 1)

l4' = l4 "hello" -- 3

l5 = length [1, 2, 3] -- 3

l6 = reverse [1, 2, 3] -- [3, 2, 1]

l7 = elem 1 [1, 2, 3] -- true

-- same
l7' = 1 `elem` [1, 2, 3] -- true

l8 = take 10 [1, 2 ..] -- [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

l9 = take 10 [1, 2] -- [1, 2]

l10 = drop 1 [1, 2, 3] -- [2,3]

l11 = zip [1, 2 ..] ['a', 'b'] -- [(1, 'a'), (2, 'b')]

l12 = cycle [1, 2] -- [1, 2, 1, 2, 1, 2, 1, 2, 1, 2 etc]

l13 = repeat 1 -- [1, 1, 1, 1 etc]

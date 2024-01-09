{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Eta reduce" #-}
{-# HLINT ignore "Use product" #-}
{-# HLINT ignore "Use sum" #-}

myProduct xs = foldl (*) 1 xs

{-

myProduct [1 .. 5] = foldl (*) 1 [1 .. 5]

\* 1 [1, 2, 3, 4, 5]
1 * 1 = 1

\* 1 [2, 3, 4, 5]
1 * 2 = 2

\* 2 [3, 4, 5]
2 * 3 = 6

\* 6 [4, 5]
6 * 4 = 24

+ 24 [5]
24 * 5 = 120

+ 120 [] = 120

-}

sumOfSquares xs = foldl (+) 0 (map (^ 2) xs)

-- foldl (+) 0 (map (^ 2) [1 .. 10]) = 385

--

myReverse xs = foldl rcons [] xs
  where
    rcons xs y = y : xs

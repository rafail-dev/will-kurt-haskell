{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore myFoldr "Use foldr" #-}

myFoldl f init [] = init
myFoldl f init (x : xs) = myFoldl f (f init x) xs

{-

myFoldl (-) 0 [1 .. 5]
- 0 [1, 2, 3, 4, 5]
0 - 1 = -1

- -1 [2, 3, 4, 5]
-1 - 2 = -3

- -3 [3, 4, 5]
-3 - 3 = -6

- -6 [4, 5]
-6 - 4 = -10

- -10 [5]
-10 - 5 = -15

- -15 [] = -15

-}

myFoldr f init [] = init
myFoldr f init (x : xs) = f x (myFoldr f init xs)

{-

myFoldr (-) 0 [1 .. 5]
1 - ( myFoldr (-) 0 [2 .. 5] )      = 1 - (-2)  = 3

myFoldr (-) 0 [2 .. 5]
2 - ( myFoldr (-) 0 [3 .. 5] )      = 2 - 4     = -2

myFoldr (-) 0 [3 .. 5]
3 - ( myFoldr (-) 0 [4 .. 5] )      = 3 - (-1)  = 4

myFoldr (-) 0 [4 .. 5]
4 - ( myFoldr (-) 0 [5] )           = 4 - 5     = -1

myFoldr (-) 0 [5]
5 - ( myFoldr (-) 0 [] )            = 5 - 0     = 5

-}

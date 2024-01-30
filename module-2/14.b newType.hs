{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

import Data.List

type Name1 = (String, String)

names1 :: [Name1]
names1 = [("B", "1"), ("A", "3"), ("C", "2")]

{-
won't compile

instance Ord Name1 where
  compare :: Name1 -> Name1 -> Ordering
  compare (f1, l1) (f2, l2) = compare (l1, f1) (l2, f2)
-}

--

{-# HLINT ignore Name2 "Use newtype instead of data" #-}
data Name2 = Name2 (String, String) deriving (Show, Eq)

instance Ord Name2 where
  compare :: Name2 -> Name2 -> Ordering
  compare (Name2 (f1, l1)) (Name2 (f2, l2)) = compare (l1, f1) (l2, f2)

names2 :: [Name2]
names2 = [Name2 ("B", "1"), Name2 ("A", "3"), Name2 ("C", "2")]

--

newtype Name3 = Name3 (String, String) deriving (Show, Eq)

instance Ord Name3 where
  compare :: Name3 -> Name3 -> Ordering
  compare (Name3 (f1, l1)) (Name3 (f2, l2)) = compare (l1, f1) (l2, f2)

names3 :: [Name3]
names3 = [Name3 ("B", "1"), Name3 ("A", "3"), Name3 ("C", "2")]

{-
won't compile
newtype X = A | B

will compile
data X = A | B
-}

main :: IO ()
main = do
  print $ sort names1
  print $ sort names2
  print $ sort names3
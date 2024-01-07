{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore compareBySurname  "Use guards" #-}

import Data.List

author = ("Will", "Kurt")

firstname = fst author

surname = snd author

names = [("F2", "L2"), ("F1", "L1"), ("F3", "L3")]

compareBySurname name1 name2 =
  if surname1 > surname2
    then GT
    else
      if surname1 < surname2
        then LT
        else EQ
  where
    surname1 = snd name1
    surname2 = snd name2

compareBySurnameWithGuards name1 name2
  | surname1 > surname2 = GT
  | surname1 < surname2 = LT
  | otherwise = EQ
  where
    surname1 = snd name1
    surname2 = snd name2

sortedBySurname = sortBy compareBySurnameWithGuards names

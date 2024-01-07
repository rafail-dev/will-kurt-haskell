import Data.List

author = ("Will", "Kurt")

firstname = fst author

surname = snd author

names = [("F2", "L1"), ("F1", "L1"), ("F3", "L3")]

compareBySurname name1 name2  = 
    case compare (snd name1) (snd name2) of 
        LT -> LT 
        GT -> GT
        EQ -> compare (fst name1) (fst name2)

result = sortBy compareBySurname names
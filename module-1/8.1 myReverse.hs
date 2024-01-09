myReverse [] = []
myReverse (x : xs) = myReverse xs ++ [x]
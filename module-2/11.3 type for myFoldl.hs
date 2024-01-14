myFoldl :: (a -> b -> a) -> a -> [b] -> [a]
myFoldl f init [] = []
myFoldl f init (x:xs) = myFoldl f (f init x) xs
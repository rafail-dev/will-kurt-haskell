mySafeTail :: [a] -> [a]
mySafeTail [] = []
mySafeTail (x:xs) = xs

-- mySafeHead :: [a] -> a
-- mySafeHead [] = ??? lesson 37
-- mySafeTail (x:xs) = x
myDrop n (x : xs) = if n == 0 then x : xs else myDrop (n - 1) xs

myDrop2 0 xs = xs
myDrop2 n (_ : xs) = myDrop (n - 1) xs

--

myLength [] = 0
myLength (_ : xs) = 1 + myLength xs

--

myTake _ [] = []
myTake 0 _ = []
myTake n (x : xs) = x : myTake (n - 1) xs

--

myCycle xs = xs ++ myCycle xs

myCycle2 (x : xs) = x : myCycle2 (xs ++ [x])

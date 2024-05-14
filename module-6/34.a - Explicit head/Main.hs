module Main where

--

data MyData = MyPair Int Int | MyEmpty deriving (Eq)

instance Semigroup MyData where
  (<>) :: MyData -> MyData -> MyData
  MyPair a1 b1 <> MyPair a2 b2 = MyPair (a1 + a2) (b1 + b2)
  MyPair a1 b1 <> MyEmpty = MyPair a1 b1
  MyEmpty <> MyPair a2 b2 = MyPair a2 b2
  MyEmpty <> MyEmpty = MyEmpty

instance Monoid MyData where
  mempty :: MyData
  mempty = MyEmpty

instance Show MyData where
  show :: MyData -> String
  show (MyEmpty) = "MyEmpty"
  show (MyPair a b) = "MyPair: " ++ show a ++ " " ++ show b

--

head :: (Monoid a) => [a] -> a
head (x : xs) = x
head [] = mempty

main :: IO ()
main = do
  print $ Main.head ([] :: [[Int]])
  print $ Main.head [[1], [2]]
  --
  print $ Main.head ([] :: [MyData])
  print $ Main.head [MyPair 1 1, MyPair 2 2]
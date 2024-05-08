data MyData = MyData
  { field1 :: String,
    field2 :: Int
  }
  deriving (Show)

data1 :: MyData
data1 = MyData {field1 = "v 1", field2 = 1}

data2 :: MyData
data2 = MyData "v 2" 2

data3Partial :: Int -> MyData
data3Partial = MyData "v 3"

data3 :: MyData
data3 = data3Partial 3

readInt :: IO Int
readInt = read <$> getLine

main :: IO ()
main = do
  putStrLn "Enter MyData"
  input <- MyData <$> getLine <*> readInt
  print input
data MyData = MyData
  { field1 :: String,
    field2 :: Int,
    filed3 :: Bool
  }
  deriving (Show)

field1Variants :: [String]
field1Variants = ["f1", "f2", "f3"]

field2Variants :: [Int]
field2Variants = [1 .. 5]

main :: IO ()
main =
  do
    print $
      pure MyData
        <*> field1Variants
        <*> field2Variants
        <*> [True, False]
data MyAlphabet = L1 | L2 | L3 | L4 | L5
  deriving (Show, Enum, Bounded)

largestMyAlphabetNumber :: Int
largestMyAlphabetNumber = fromEnum (maxBound :: MyAlphabet) + 1

largestCharNumber :: Int
largestCharNumber = fromEnum (maxBound :: Char) + 1

rotNEncoder :: (Enum a) => Int -> a -> a
rotNEncoder size symbol = toEnum $ mod offset size
  where
    offset =
      div size 2
        + fromEnum symbol

rotNDecoder :: (Enum a) => Int -> a -> a
rotNDecoder size symbol = toEnum $ mod offset size
  where
    offset =
      div size 2
        + fromEnum symbol
        + if even size
          then 0
          else 1

encodeText :: (Bounded a, Enum a) => Int -> [a] -> [a]
encodeText size = map $ rotNEncoder size

decodeText :: (Enum a) => Int -> [a] -> [a]
decodeText size = map $ rotNDecoder size

main :: IO ()
main = do
  print $ rotNEncoder largestMyAlphabetNumber L1
  print $ rotNDecoder largestMyAlphabetNumber L3
  print $ rotNEncoder largestCharNumber 'a'
  print $ rotNDecoder largestCharNumber '\557153'
  print $ encodeText largestMyAlphabetNumber [L1,L2,L3,L4,L2,L4,L5]
  print $ decodeText largestMyAlphabetNumber [L3,L4,L5,L1,L4,L1,L2]
  print $ encodeText largestCharNumber "Hello, World!"
  print $ decodeText largestCharNumber "\557128\557157\557164\557164\557167\557100\557088\557143\557167\557170\557164\557156\557089"
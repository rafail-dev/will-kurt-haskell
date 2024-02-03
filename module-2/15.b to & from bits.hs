type Bits = [Bool]

intToBits :: Int -> Bits
intToBits n = replicate leadingLength False ++ significant
  where
    intToBits' :: Int -> Bits
    intToBits' 0 = [False]
    intToBits' 1 = [True]
    intToBits' n = odd n : intToBits' (div n 2)

    significant = reverse (intToBits' n)
    leadingLength = length (intToBits' maxBound) - length significant

charToBits :: Char -> Bits
charToBits = intToBits . fromEnum

bitsToInt :: Bits -> Int
bitsToInt bits = sum $ map ((2 ^) . snd) bitsForResultWithExponents
  where
    exponents = [length bits - 1, length bits - 2 .. 0]
    bitsForResultWithExponents = filter fst $ zip bits exponents

bitsToChar :: Bits -> Char
bitsToChar bits = toEnum $ bitsToInt bits

main :: IO ()
main = do
  print $ bitsToInt $ intToBits 100
  print $ bitsToChar $ charToBits 'a'
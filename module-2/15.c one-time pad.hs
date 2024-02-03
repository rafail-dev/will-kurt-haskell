type Bits = [Bool]

class Cipher a where
  encode :: a -> String -> String
  decode :: a -> String -> String

newtype StreamCipher = StreamCipher Int

instance Cipher StreamCipher where
  encode :: StreamCipher -> String -> String
  encode (StreamCipher seed) = otp $ randomStringFromSeed seed
  decode :: StreamCipher -> String -> String
  decode (StreamCipher seed) = otp $ randomStringFromSeed seed

-- ==

xorPair :: (Bits, Bits) -> Bits
xorPair = uncurry $ zipWith (/=)

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

-- ===

otp :: String -> String -> String
otp s1 s2 = map bitsToChar xored
  where
    bits1 = map charToBits s1
    bits2 = map charToBits s2
    xored = zipWith (curry xorPair) bits1 bits2

-- ==

myPrng :: Int -> Int
myPrng = makePrng 1337 7 100
  where
    makePrng a b max seed = mod (a * seed + b) max

randomStringFromSeed :: Int -> String
randomStringFromSeed seed = map (bitsToChar . intToBits) randomSeries
  where
    randomSeries = iterate myPrng $ myPrng seed

-- ==

main :: IO ()
main = do
  let sc1 = StreamCipher 483904
  let sc2 = StreamCipher 240940
  let encoded = encode sc1 "Hello, Haskell!"
  let correctlyDecoded = decode sc1 encoded
  let incorrectlyDecoded = decode sc2 encoded
  print incorrectlyDecoded
  print correctlyDecoded

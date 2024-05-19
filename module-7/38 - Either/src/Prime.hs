{-
data Either a b = Left a | Right b

Left fo errors
Right for successfully computed results
-}

module Prime
  ( isPrime,
  )
where

data PrimeError = TooLarge | InvalidValue deriving (Show)

primes :: [Int]
primes = [2, 3, 5, 7]

maxN :: Int
maxN = 10

isPrime :: Int -> Either PrimeError Bool
isPrime n
  | n < 2 = Left InvalidValue
  | n > maxN = Left TooLarge
  | even n = Right False
  | otherwise = Right $ elem n primes

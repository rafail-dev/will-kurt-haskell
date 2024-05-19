module Primes (isPrime, primes', isPrime') where

sieve :: [Int] -> [Int]
sieve [] = []
sieve (nextPrime : rest) = nextPrime : sieve noFactors
  where
    noFactors = filter ((/= 0) . (`mod` nextPrime)) rest

primes :: [Int]
primes = sieve [2 .. 10000]

isPrime :: Int -> Maybe Bool
isPrime n
  | n < 2 = Nothing
  | n == 2 = Just True
  | even n = Just False
  | n >= length primes = Nothing
  | otherwise = Just $ elem n primes

--

primes' :: Int -> [Int]
primes' n = filterPrime [2 .. n]
  where
    filterPrime [] = []
    filterPrime (p : xs) =
      p : filterPrime [x | x <- xs, x `mod` p /= 0]

isPrime' :: Int -> Maybe Bool
isPrime' n
  | n < 2 = Nothing
  | n == 2 = Just True
  | even n = Just False
  | otherwise = Just $ elem n $ primes' n
module Primes (isPrime, primes, primes') where

sieve :: [Int] -> [Int]
sieve [] = []
sieve (nextPrime : rest) = nextPrime : sieve noFactors
  where
    noFactors = filter ((/= 0) . (`mod` nextPrime)) rest

primes :: [Int]
primes = sieve [2 .. 10000]

primes' :: [Integer]
primes' = filterPrime [2 ..]
  where
    filterPrime [] = []
    filterPrime (p : xs) =
      p : filterPrime [x | x <- xs, x `mod` p /= 0]

isPrime :: Int -> Maybe Bool
isPrime n
  | n < 2 = Nothing
  | n >= length primes = Nothing
  | otherwise = Just $ elem n primes
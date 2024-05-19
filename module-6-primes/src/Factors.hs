module Factors
  ( primeFactors,
  )
where

import Primes (primes')

unsafePrimeFactors :: Int -> [Int] -> [Int]
unsafePrimeFactors _ [] = []
unsafePrimeFactors n (next : primes) =
  if mod n next == 0
    then next : unsafePrimeFactors (div n next) (next : primes)
    else unsafePrimeFactors n primes

primeFactors :: Int -> Maybe [Int]
primeFactors n
  | n < 2 = Nothing
  | otherwise = Just $ unsafePrimeFactors n $ primes' n

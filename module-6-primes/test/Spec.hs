import Data.Maybe (isJust, isNothing)
import MillerRabin (MillerRabin (..), test)
import Primes (isPrime)
import Test.QuickCheck

prop_primesArePrime :: Int -> Bool
prop_primesArePrime v = (result /= Just True) || null (divisors v)
  where
    result = isPrime v

divisors :: Int -> [Int]
divisors v = [x | x <- [2 .. v - 1], (v `mod` x) == 0]

prop_validPrimesOnly :: Int -> Bool
prop_validPrimesOnly v
  | v < 2 = isNothing result
  | otherwise = isJust result
  where
    result = isPrime v

prop_nonPrimesAreComposite :: Int -> Bool
prop_nonPrimesAreComposite v = (result /= Just False) || not (null (divisors v))
  where
    result = isPrime v

prop_millerRabin :: Int -> Bool
prop_millerRabin v
  | v < 2 = isNothing result
  | even v = isNothing result
  | otherwise = (result /= Just PossiblyPrime) || null (divisors v)
  where
    result = MillerRabin.test v

main :: IO ()
main = do
  quickCheck prop_validPrimesOnly
  quickCheck prop_primesArePrime
  quickCheck prop_nonPrimesAreComposite
  quickCheck prop_millerRabin

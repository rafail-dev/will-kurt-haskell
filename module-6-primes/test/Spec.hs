import Data.Maybe (isJust, isNothing)
import Primes (isPrime, primes)
import Test.QuickCheck (quickCheck)

prop_primesArePrime :: Int -> Bool
prop_primesArePrime v =
  (result /= Just True) || null (divisors v)
  where
    result = isPrime v

-- prop_primesArePrime :: Int -> Bool
-- prop_primesArePrime v =
--   if result == Just True
--     then length (divisors v) == 0
--     else True
--   where
--     result = isPrime v

-- divisors'' :: Int -> [Int]
-- divisors'' v = filter ((== 0) . (v `mod`)) [2 .. (v - 1)]

-- import Control.Monad (guard)
-- divisors' :: Int -> [Int]
-- divisors' v = do
--   x <- [2 .. v - 1]
--   guard ((v `mod` x) == 0)
--   pure x

divisors :: Int -> [Int]
divisors v = [x | x <- [2 .. v - 1], (v `mod` x) == 0]

prop_validPrimesOnly :: Int -> Bool
prop_validPrimesOnly v
  | v < 2 = isNothing result
  | v >= length primes = isNothing result
  | otherwise = isJust result
  where
    result = isPrime v

prop_nonPrimesAreComposite :: Int -> Bool
prop_nonPrimesAreComposite v =
  (result /= Just False) || not (null (divisors v))
  where
    result = isPrime v

main :: IO ()
main = do
  quickCheck prop_validPrimesOnly
  quickCheck prop_primesArePrime
  quickCheck prop_nonPrimesAreComposite

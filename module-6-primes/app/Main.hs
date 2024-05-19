module Main
  ( main,
  )
where

import Factors (primeFactors)
import MillerRabin (test)
import Primes (isPrime')
import Text.Read (readMaybe)

main :: IO ()
main = do
  putStrLn "Welcome! Enter a number to check if it is prime:"
  n <- readMaybe <$> getLine
  case n >>= isPrime' of
    Nothing ->
      putStrLn
        "The number is less than or equal to 2, which are not considered prime"
    (Just False) -> putStrLn "The number is not prime"
    (Just True) -> putStrLn "The number is prime"
  case n >>= primeFactors of
    Nothing ->
      putStrLn "The number must be greater than 2 to find its prime factors"
    (Just v) -> putStrLn $ "The prime factors of the number are:" ++ show v
  case n >>= MillerRabin.test of
    Nothing -> putStrLn "The number must be odd and greater than 2"
    (Just v) -> print v

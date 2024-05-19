module Main (main) where

import Homework381 (addStrInts)
import Nested (f)
import Prime (isPrime)
import Text.Read (readEither)

main :: IO ()
main = do
  putStrLn "Please enter a number"
  v1 <- readEither <$> getLine

  case isPrime <$> v1 of
    Left e -> print e
    Right result -> print result

  putStrLn ""
  --

  putStrLn "Nested errors"
  let v2 = Nested.f True
  print v2

  putStrLn ""
  --

  putStrLn "Homework 38.1"
  putStrLn "Please enter a number"
  v31 <- getLine
  v32 <- getLine
  print $ addStrInts v31 v32

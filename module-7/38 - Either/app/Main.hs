module Main (main) where

import Prime (isPrime)
import Nested (f)
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

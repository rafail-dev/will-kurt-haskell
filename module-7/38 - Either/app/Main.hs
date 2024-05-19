module Main
  ( main,
  )
where

import Homework381 (addStrInts)
import Homework382 (last', succ', tail')
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
  putStrLn "Please enter two numbers"
  v31 <- getLine
  v32 <- getLine
  print $ addStrInts v31 v32
  putStrLn ""
  --

  putStrLn "Homework 38.2"
  putStrLn "succ'"
  print $ succ' (maxBound - 1 :: Int)
  print $ succ' (maxBound :: Int)

  putStrLn "tail'"
  print $ tail' ""
  print $ tail' "hello"

  putStrLn "last'"
  let last'' = last' 10000
  print $ last'' ""
  print $ last'' ['a', 'b' ..]
  print $ last'' "hello"

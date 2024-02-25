module Main21c where

import Modules21.Pizza (Pizza (..), pricePer)
import Text.Read (readMaybe)

prompt :: String -> IO Double
prompt message = do
  putStrLn message
  input <- getLine
  case readMaybe input of
    Just value -> return value
    Nothing -> do
      putStrLn "Invalid input, please enter a number"
      prompt message

main :: IO ()
main =
  do
    diameter1 <- prompt "What is the diameter of Pizza 1"
    price1 <- prompt "What is the price of Pizza 1"
    diameter2 <- prompt "What is the diameter of Pizza 2"
    price2 <- prompt "What is the price of Pizza 2"

    let pizza1 = Pizza diameter1 price1
    let pizza2 = Pizza diameter2 price2

    case compare pizza1 pizza2 of
      EQ -> putStrLn "Same"
      GT -> putStrLn "Winner - Pizza 1"
      LT -> putStrLn "Winner - Pizza 2"

{-
  without checking

  putStrLn "What is the size of pizza 1"
  size1 <- getLine

  etc
-}
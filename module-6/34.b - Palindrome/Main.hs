module Main where

import Control.Monad (ap)
import Palindrome (isPalindrome)

main :: IO ()
main = do
  putStrLn "Enter a word to check if it is a palindrome"
  result <- (isPalindrome <$> getLine)
  print result
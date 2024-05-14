module Main where

import Control.Monad (ap)
import Data.Text.IO qualified as TIO (getLine)
import Palindrome (isPalindrome)

main :: IO ()
main = do
  putStrLn "Enter a word to check if it is a palindrome"
  result <- (isPalindrome <$> TIO.getLine)
  print result
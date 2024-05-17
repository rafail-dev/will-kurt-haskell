module Main (main) where

import Data.Text.IO as TIO
import Palindrome (isPalindrome)

main :: IO ()
main = do
  TIO.putStrLn "Please enter a text to check if it is a palindrome:"
  input <- TIO.getLine

  if (isPalindrome input)
    then TIO.putStrLn "Congratulations! The text you entered is a palindrome."
    else TIO.putStrLn "Sorry, the text you entered is not a palindrome."
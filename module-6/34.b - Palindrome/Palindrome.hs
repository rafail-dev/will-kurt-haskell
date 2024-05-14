module Palindrome (isPalindrome) where

import Data.Char (isPunctuation, isSpace, toLower)

preprocess :: String -> String
preprocess =
  filter (not . isSpace)
    . filter (not . isPunctuation)
    . map toLower

-- OR
-- notIsSpaceAndnotIsPucntuation :: String -> String
-- notIsSpaceAndnotIsPucntuation = filter (liftA2 (||) isPunctuation isSpace)

isPalindrome :: String -> Bool
isPalindrome s = s' == reverse s'
  where
    s' = preprocess s
module Palindrome
  ( isPalindrome,
  )
where

import Data.Char (isPunctuation, isSpace)
import Data.Text as T

preprocess :: T.Text -> T.Text
preprocess =
  T.filter (not . isSpace)
    . T.filter (not . isPunctuation)
    . T.toLower

isPalindrome :: T.Text -> Bool
isPalindrome s = s' == T.reverse s'
  where
    s' = preprocess s
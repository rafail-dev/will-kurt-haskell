module Palindrome (isPalindrome) where

import Data.Char (isPunctuation, isSpace, toLower)
import Data.Text qualified as T (Text, filter, reverse, toLower)

f :: T.Text -> T.Text
f s = T.filter (\v -> True) s

preprocess :: T.Text -> T.Text
preprocess =
  T.filter (not . isSpace)
    . T.filter (not . isPunctuation)
    . T.toLower

-- OR
-- notIsSpaceAndnotIsPucntuation :: T.Text -> T.Text
-- notIsSpaceAndnotIsPucntuation = T.filter (liftA2 (||) isPunctuation isSpace)

isPalindrome :: T.Text -> Bool
isPalindrome t = t' == T.reverse t'
  where
    t' = preprocess t
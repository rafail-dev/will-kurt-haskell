module Lib (isPalindrome, preprocess) where

import Data.Char (isPunctuation, isSpace)
import qualified Data.Text as T

isPalindrome :: T.Text -> Bool
isPalindrome text = preprocess text == (preprocess $ T.reverse text)

preprocess :: T.Text -> T.Text
preprocess = T.toLower . T.filter (not . isPunctuation) . T.filter (not . isSpace)
import Data.Char

isPalindrome str = preparedString == reverse preparedString
  where
    preparedString = map toLower (filter (/= ' ') str)
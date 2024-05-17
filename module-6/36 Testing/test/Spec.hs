import Data.Char (isPunctuation, isSpace)
import qualified Data.Text as T
import Lib (isPalindrome, preprocess)
import Test.QuickCheck
import Test.QuickCheck.Instances ()

prop_punctuationInvariant :: T.Text -> Bool
prop_punctuationInvariant text =
  preprocess text
    == (preprocess $ T.filter (not . isPunctuation) text)

prop_reverseInvariant :: T.Text -> Bool
prop_reverseInvariant text = isPalindrome text == (isPalindrome (T.reverse text))

prop_uppercaseInvariatn :: T.Text -> Bool
prop_uppercaseInvariatn text = preprocess text == preprocess cleared
  where
    cleared = T.toLower text

prop_spaceInvariant :: T.Text -> Bool
prop_spaceInvariant text = preprocess text == preprocess cleared
  where
    cleared = T.filter (not . isSpace) text

prop_emptyStringInvariant :: T.Text -> Property
prop_emptyStringInvariant text = T.null text ==> T.null (preprocess text)

main :: IO ()
main = do
  putStrLn "Running tests"
  quickCheckWith
    stdArgs
      { maxSuccess = 1000
      }
    prop_punctuationInvariant
  quickCheck prop_reverseInvariant
  quickCheck prop_uppercaseInvariatn
  quickCheck prop_spaceInvariant
  quickCheck prop_emptyStringInvariant
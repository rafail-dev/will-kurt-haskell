import Data.Char (isDigit)
import Data.Maybe (mapMaybe)
import Text.Read (readMaybe)

isDigitStr :: String -> Bool
isDigitStr = all isDigit

parse :: [Char] -> [String]
parse = foldl next [] . filter (`notElem` [' ', '\n'])
  where
    next :: [String] -> Char -> [String]
    next [] current = [[current]]
    next (x : xs) current
      | isDigit current && isDigitStr x = (x ++ [current]) : xs
      | otherwise = [current] : x : xs

calculate :: (Fractional a) => [String] -> Maybe a
calculate [n1, "/", "0"] = Nothing
calculate [n1, f, n2] =
  case f of
    "+" -> result (+)
    "-" -> result (-)
    "*" -> result (*)
    "/" -> result (/)
    _ -> Nothing
  where
    justed = map realToFrac $ mapMaybe readMaybe [n1, n2]
    result f
      | length justed == 2 = Just $ f (justed !! 1) (head justed)
      | otherwise = Nothing
calculate _ = Nothing

operate :: (Fractional a) => [Char] -> Maybe a
operate = calculate . parse

main :: IO ()
main = do
  userInput <- getContents
  print $ operate userInput
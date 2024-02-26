{-
cabal install split --lib
-}
import Data.List.Split (splitOn)
import Data.Maybe (catMaybes, isJust, mapMaybe)
import Text.Read (readMaybe)

toInts :: String -> [Int]
toInts = mapMaybe readMaybe . splitOn "\n"

{-
CTRL + Z for stop in ghci

For compiled
1
2
3
4
5
CTRL + D
15
-}
main :: IO ()
main = do
  userInput <- getContents
  let numbers = toInts userInput
  print $ sum numbers
import Control.Monad (when)
import Text.Read (readMaybe)

isMore :: IO Bool
isMore = do
  putStrLn "More? y \\ n"
  answer <- getLine
  case answer of
    "y" -> return True
    _ -> return False

inputN :: IO String
inputN = do
  putStrLn "Please enter N"
  n <- getLine
  case readMaybe n :: Maybe Int of
    Just value -> return $ "Super: " ++ show value
    _ -> inputN

main :: IO ()
main = do
  n <- inputN
  putStrLn n
  more <- isMore
  when more main
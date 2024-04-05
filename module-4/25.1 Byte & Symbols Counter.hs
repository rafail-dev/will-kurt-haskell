import Data.ByteString qualified as B
import Data.Text as T
import Data.Text.Encoding qualified as E
import System.IO

main :: IO ()
main = do
  input <- B.readFile "25.1 Sample.txt"
  putStrLn $ "Bytes: " ++ show (B.length input)
  putStrLn $ "Symbols: " ++ show (T.length $ E.decodeUtf8 input)
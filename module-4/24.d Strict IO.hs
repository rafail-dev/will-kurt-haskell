import Data.Text qualified as T
import Data.Text.IO qualified as TIO

filename :: String
filename = "24.d.txt"

main :: IO ()
main = do
  input <- TIO.readFile filename
  TIO.writeFile filename $ T.unwords [input, input]
import Data.Map qualified as Map
import Data.Maybe (fromMaybe)
import Text.Read (readMaybe)

quotes :: Map.Map Int String
quotes = Map.fromList $ zip [1, 2 ..] ["Quota A", "Quota B", "Quota C", "Quota D"]

ui :: String -> [String] -> [String]
ui "n" _ = []
ui "y" lazy = "Please enter number" : lazy
ui current lazy = message : "Another quote?" : lazy
  where
    maybeId = readMaybe current :: Maybe Int
    maybeQuota = maybeId >>= (flip Map.lookup quotes)
    message = fromMaybe "Quote not found" maybeQuota

main :: IO ()
main = do
  userInput <- getContents
  mapM_ putStrLn . foldr ui [] $ lines userInput

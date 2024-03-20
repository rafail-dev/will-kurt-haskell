{--
cabal install text --lib
--}
import Data.Text qualified as T

fromStringToText :: String -> T.Text
fromStringToText = T.pack

fromTextToString :: T.Text -> String
fromTextToString = T.unpack

main :: IO ()
main = do
  print $ fromStringToText "Hello"
  print $ fromTextToString $ fromStringToText "World"
import Data.ByteString.Char8 as BC (readFile, writeFile)
import Data.List
import Modules25.Glitch (glitch)
import System.Environment

maybeFilePath :: [String] -> Maybe FilePath
maybeFilePath (path : _) = Just path
maybeFilePath _ = Nothing

addGlitchedToPath :: FilePath -> FilePath
addGlitchedToPath path = case added of
  Just added -> Prelude.reverse added
  Nothing -> mconcat [path, ".glitched"]
  where
    reversed = Prelude.reverse path
    splitted = Data.List.elemIndex '.' reversed >>= Just . (flip Data.List.splitAt reversed)
    added = splitted >>= Just . (\(p1, p2) -> mconcat [p1, Prelude.reverse "glitched.", p2])

main :: IO ()
main = do
  agrs <- getArgs
  case (maybeFilePath agrs) of
    Just path -> BC.readFile path >>= glitch >>= BC.writeFile (addGlitchedToPath path)
    Nothing -> Prelude.putStrLn "Wrong paths"

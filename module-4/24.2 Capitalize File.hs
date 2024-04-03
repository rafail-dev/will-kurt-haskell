import Data.Char (toUpper)
import System.Environment (getArgs)

maybeTwoArgs :: [String] -> Maybe (FilePath, FilePath)
maybeTwoArgs (path1 : path2 : xs) = Just (path1, path2)
maybeTwoArgs _ = Nothing

capitalize :: String -> String
capitalize "" = ""
capitalize (first : tail) = toUpper first : tail

capitalizeLine :: String -> String
capitalizeLine = unwords . map capitalize . words

capitalizeFile :: String -> String
capitalizeFile = unlines . map capitalizeLine . lines

main :: IO ()
main = do
  args <- getArgs
  case (maybeTwoArgs args) of
    Just (path1, path2) ->
      readFile path1 >>= (writeFile path2) . capitalizeFile
    Nothing -> putStrLn "Wrong paths"
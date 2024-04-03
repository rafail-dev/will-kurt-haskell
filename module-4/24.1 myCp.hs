import System.Environment (getArgs)

maybeTwoArgs :: [String] -> Maybe (FilePath, FilePath)
maybeTwoArgs (path1 : path2 : xs) = Just (path1, path2)
maybeTwoArgs _ = Nothing

main :: IO ()
main = do
  args <- getArgs
  case (maybeTwoArgs args) of
    Just (path1, path2) -> readFile path1 >>= writeFile path2
    Nothing -> putStrLn "Wrong paths"
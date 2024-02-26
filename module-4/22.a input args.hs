import Control.Monad
import System.Environment

{-
ghci
withArgs ["1", "2", "3"] main
-}
allArgs :: IO ()
allArgs = do
  args <- getArgs
  mapM_ putStrLn args

{-
ghci
withArgs ["1", "2", "3"] firstArgOrZero
-}
firstArgOrZero :: IO ()
firstArgOrZero = do
  args <- getArgs
  let linesToRead =
        if not (null args)
          then read (head args)
          else 0 :: Int
  print linesToRead

{-
ghci
withArgs ["3""] main
-}
main :: IO ()
main = do
  args <- getArgs
  let linesToRead =
        if not (null args)
          then read (head args)
          else 0 :: Int
  numbers <- replicateM linesToRead getLine
  print $ sum $ map read numbers